package notifier

import (
	"fmt"
	"sync"
)

type String struct {
	value       string
	subscribers map[string]chan string
	lock        sync.Mutex
}

func (n *String) Get() string {
	n.lock.Lock()
	defer n.lock.Unlock()
	return n.value
}

func (n *String) Set(value string) {
	n.lock.Lock()
	defer n.lock.Unlock()

	n.value = value
	for _, c := range n.subscribers {
		c <- value
	}
}

func (n *String) Subscribe(name string, sub chan string) error {
	n.lock.Lock()
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

func (n *String) UnSubscribe(name string) {
	n.lock.Lock()
	defer n.lock.Unlock()

	delete(n.subscribers, name)
}
