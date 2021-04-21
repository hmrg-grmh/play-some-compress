# simple demo

# compress
tar cf - * | xz -T0 --best > baged.tar.xz

# decompress
xz -d baged.tar.xz --stdout | tar -x
tar xJf baged.txz


# compress e.g.
function tar_xz () { tar cpPf - "${1:-.}" | xz -T0 --best > "${1:-${PWD##*/}}"_t"$(date +%Y%m%dT%H%:::z)".tar.xz ; }
tar_xz somedir
