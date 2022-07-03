Implementation of a peer-to-peer game that uses WebRTC.
The connection uses (D)TLS everywhere which makes this client deployable to secure web pages such as itch.io.

A Nakama instance is used as the Signaling Server.

The goal is to implement Pong. 
After that it would be possible to implement rollback as well with its Godot plugin.


### TODOS
- [ ] Change Nakama connection to use godot-nakama plugin
- [ ] Use Control nodes to react properly to changing resolutions