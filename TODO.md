# TODO list

Things to do next

* Determine what squad info should be displayed on the squad list of the main roster page
* Update Dark Warrior upgrades
* Should Loadouts and Upgrades be different types
* Convert unit data from JSON to Protocol Buffers (or compact binary format) for compact asset storage
* Implement a pre-build script to compile source `.json` / `.proto` files to `.pb` assets outside `pubspec.yaml` (preventing source files from being included in Web builds)
  * Note: Alternatively, consider embedding compiled binary data directly in generated Dart code (`.g.dart`) to eliminate asset files and network requests entirely on Web.
* Add asset integrity & tamper detection (SHA-256 asset manifest verification or digital signatures)
* Replace `JsonUnitRepository` and `UnitJsonParser` with a binary `ProtobufUnitRepository` and `ProtobufUnitParser`