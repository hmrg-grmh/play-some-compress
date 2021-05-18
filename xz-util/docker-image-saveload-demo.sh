# tar bag

# save out
docker save docker.io/hello-world -o hello.tar
docker save docker.io/hello-world > hello.tar

# load in
docker load -i hello.tar
docker load < hello.tar


# tar.xz bag

# save out
docker save docker.io/hello-world | xz -T0 --best > hello.tar.xz
# [!!] do not use -o /dev/stdout or > /dev/stdout !!!!

# load in
xz -d hello.tar.xz --stdout | docker load
xz -d hello.tar.xz --stdout | docker load < /dev/stdin
xz -d hello.tar.xz --stdout | docker load -i /dev/stdin


# tar.xz bag by-image(s) in-parallel

# save image(s)
echo docker.io/rakudo-star:alpine | xargs -P0 -i{x} /usr/bin/bash -c 'docker pull '"'"{x}"'"' ; docker save '"'"{x}"'"' |  xz -T0 --best > "$(basename '"'"{x}"'"')".tar.xz'
cat xxx | xargs -P0 -i{x} /usr/bin/bash -c 'docker pull '"'"{x}"'"' ; docker save '"'"{x}"'"' |  xz -T0 --best > "$(basename '"'"{x}"'"')".tar.xz'
cat xxx | xargs -P0 -i{x} /usr/bin/bash -c 'docker pull '"'"{x}"'"' ; mkdir -p .../xxxx/"$(dirname '"'"{x}"'"')" ; docker save '"'"{x}"'"' |  xz -T0 --best > .../xxxx/'"'"{x}"'"'.tar.xz'

# load image(s)
cd .../xxxx ; find -name \*.tar.xz -type f | xargs -P0 -i{x} /usr/bin/bash -c 'xz -d '"'"{x}"'"' --stdout | docker load'

# may be ...
cat xxx | grep -Ev ^\#\|^\$ | xargs -P0 -i{x} /usr/bin/bash -c 'docker pull '"'"{x}"'"' ; mkdir -p .../xxxx/"$(dirname '"'"{x}"'"')" ; docker save '"'"{x}"'"' |  xz -T0 --best > .../xxxx/'"'"{x}"'"'.tar.xz'

### images witten in xxx file and back bag will out to some dir ;
### file name is always not include docker.io or swr.cn-east-2.myhuaweicloud.com/kuboard etc. ;
### xargs -P <num> can setting the degree of parallelism , and 0 means full for the using cpu core ;
