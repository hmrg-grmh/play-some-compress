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
