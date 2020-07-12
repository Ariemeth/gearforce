package notifier

import (
	"fmt"
	"sync"
)

// String provides an observable wrapper around a string.  This allows a subscriber to be notified when the value has changed.
type String struct {
	value       string
	subscribers map[string]chan string
	lock        sync.Mutex
}

// Get returns the value of the string.
func (n *String) Get() string {
	fmt.Println("locking")
	n.lock.Lock()
	defer fmt.Println("unlocking")
	defer n.lock.Unlock()
	return n.value
}

// Set replaces the existing value with the new value and notifies subscribers of the change.
func (n *String) Set(value string) {
	fmt.Println("locking")
	n.lock.Lock()
	defer fmt.Println("unlocking")
	defer n.lock.Unlock()

	n.value = value
	for _, c := range n.subscribers {
		c <- value
	}
}

// Subscribe is used to request future changes of the string value.
func (n *String) Subscribe(name string, sub chan string) error {
	fmt.Println("locking")
	n.lock.Lock()
	defer fmt.Println("unlocking")
	defer n.lock.Unlock()

	if n.subscribers == nil {
		n.subscribers = make(map[string]chan string)
	}

	if _, exists := n.subscribers[name]; exists {
		return fmt.Errorf("subscription for %s already exists", name)
	}

	n.subscribers[name] = sub

	return nil
}

// UnSubscribe will remove the indicated subscriber from recieving future updates.
func (n *String) UnSubscribe(name string) {
	fmt.Println("locking")
	n.lock.Lock()
	defer fmt.Println("unlocking")
	defer n.lock.Unlock()

	delete(n.subscribers, name)
}
