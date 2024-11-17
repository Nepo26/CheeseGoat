[//]: # (TODO Improve debugging and development documentation)
# How to debug GitHub Actions

We utilize GitHub actions as our CI/CD process. Below is detailed how to debug and run it locally.

You may run the following command to build the image locally and
be able to run it with `docker run`:
```bash
$ CLICOLOR_FORCE=1 gh act -j build_image | grep --color=always -v '::debug'
```
