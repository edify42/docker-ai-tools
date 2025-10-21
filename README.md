# docker-ai-tools

Since the `nx` injection attack in Aug 2025, I'm quite weary of running
`gemini` or `claude` on my machine without wrapping it into a container of
some kind.

I advise all people fork / make their own copy of this for their personal usage.

## run

Have environment variables set for gemini + claude (optional) and be in the directory you want to run this docker container to mount the volume.

```bash
docker run -it -v $PWD:/workdir -e GEMINI_API_KEY -e ANTHROPIC_API_KEY tedk42/ai-tools
```

## development habbit changes

When using these tools, it'll be in an isolated sandbox environment without
access to the main terminal/host OS.

## build + push cmd

using `tedk42` user account, I push my changes manually.

Pull via `docker pull tedk42/ai-tools` though I highly recommend self-hosting
this yourself and auditing the code.

```
docker build . -t ai-tools -f docker/Dockerfile
docker tag ai-tools tedk42/ai-tools
docker push tedk42/ai-tools
```

Compressed size is around 800MB at the time of writing.

### linux notes

Debian is the safe bet here as opposed to alpine linux which may encounter its
own issues (g++, make, python3 issuess)

the `node` user has UID 1000 which if you want to play nicely with your user should be the same UID.

Update [Dockerfile](./docker/Dockerfile) and build your own if needed.

## claude-code

Needs a lot of 'baked in' stuff into the `~/.claude.json` file so that claude
can open on first run without going through the setup dialogs.

Requires `ANTHROPIC_API_KEY` to be set in environment

## gemini-code

Just works based on `GEMINI_API_KEY` env variable
