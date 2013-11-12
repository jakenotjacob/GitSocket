GitSocket
=========
After going through some pains in attempting to get Post-Receive Hooks working
for my server, I decided to instead use Git's WebHook request
(POST to given URL when pushing to BRANCH) to trigger a git-pull.

This is a socket that:
- Listens for requests made by a GitHub WebHook
- Verifies the request by ensuring it is coming from a server in
GitHub's subnet (this initial request is created on initialization)
- Runs a command* if the request is valid.

*Due to the fact that "git pull" command varies per-basis, I have
not included this portion of code. That is up to you to create.

Please DO NOT execute the code without first
checking it out and modifying it for your own needs!

Using
-----
Ensure you have correct port-forwarding setup for the port you specify.

1) Setup Git WebHook: give it your URL and PORT of choice. (0.0.0.0:1234)
2) Insert your personalized command to run. (See comments inside listen() )
3) Initialize GitSocket to listen on the port you provided for the WebHook.
4) Run GitSocket and let the pushes flow in.

Notes
-----
The POST request does contain a JSON payload of relevant commit data, but
for my current purposes this was not needed and so I chose not to parse it.
BUT, in the future I will be looking into the possiblity of adding this for
integration with log files on the server.


Additional Information
----------------------
GitHub Post-Receive/Webhooks:
- https://help.github.com/articles/post-receive-hooks
