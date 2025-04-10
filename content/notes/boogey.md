---
title: AWS 
date: 2023-08-01
tags: [networking,homelab]
---

obsfucation :

origin is the actual script 

```
echo "echo $(base64 origin)" > obsf
chmod +x obsf
```

Running it 
```
sh obsf | base64 -d | sh
```

