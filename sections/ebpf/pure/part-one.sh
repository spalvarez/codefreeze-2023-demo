

#!/bin/bash

git clone https://github.com/cilium/ebpf.git

cd examples

go run -exec sudo [./xdp]


