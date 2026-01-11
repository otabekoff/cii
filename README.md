# Jlox programming language

Made in Rust, learned from Java version on Crafting Interpreters. 

To release v1:
```bash
git tag v1.0.0 && git push origin v1.0.0
```

The tag already exists locally? — push it (or inspect/replace it). Pick one:

If you just need to push the existing tag:
```bash
git push origin v1.0.0
```

Inspect the tag and commit it points to first:
```bash
git tag -l v1.0.0
git show v1.0.0 --no-patch --pretty=%H   # tag target commit
git rev-parse HEAD  
```

If the tag exists but you want to retarget it to the current HEAD and update remote:
```bash
git tag -f v1.0.0 HEAD
git push --delete origin v1.0.0
git push origin v1.0.0
```

Alternative: trigger the workflow manually from the Actions tab (we included workflow_dispatch), no tag needed.