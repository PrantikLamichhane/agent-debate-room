# Publish Checklist

The local repo is ready at:

```text
/Users/arivariv/agent-debate-room
```

## GitHub Remote

Expected remote:

```text
git@github.com:PrantikLamichhane/agent-debate-room.git
```

Current status:

- local git repo initialized
- initial commit created
- remote `origin` configured
- GitHub repo does not exist yet

## To Publish

Create a blank public GitHub repo named:

```text
agent-debate-room
```

Do not initialize it with a README, license, or gitignore.

Then run:

```bash
cd /Users/arivariv/agent-debate-room
git push -u origin main
```

## After Publish

1. Replace `[repo link]` in `marketing/LINKEDIN-POST.md`.
2. Replace `[repo link]` in `marketing/X-THREAD.md`.
3. Post LinkedIn first.
4. Post X thread second.
5. Share in one relevant developer community only after the repo link is live.
