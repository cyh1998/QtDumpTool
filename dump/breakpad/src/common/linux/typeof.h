#ifndef COMMON_LINUX_TYPEOF_H
#define COMMON_LINUX_TYPEOF_H

#include <type_traits>
#define TYPEOF(x) std::remove_reference<decltype(x)>::type

#endif
