/**
 * File              : utils_cub.cuh
 * Author            : Yibo Lin <yibolin@pku.edu.cn>
 * Date              : 06.25.2021
 * Last Modified Date: 06.25.2021
 * Last Modified By  : Yibo Lin <yibolin@pku.edu.cn>
 */

#ifndef _DREAMPLACE_UTILITY_UTILS_CUB_CUH
#define _DREAMPLACE_UTILITY_UTILS_CUB_CUH

#include "utility/src/namespace.h"

#include <cuda.h>

#if CUDA_VERSION >= 12000
// CCCL 2.x (CUDA 12.x) no longer supports the CUB_NS_PREFIX wrapping trick:
// wrapping the cub headers in an outer namespace breaks their internal
// references to ::cuda::proclaim_return_type / ::cuda::discard_memory
// (they resolve to DreamPlace::cuda instead). Include cub at global scope
// and alias it into the DreamPlace namespace so existing unqualified
// cub:: references keep working.
#include <cub/cub.cuh>
namespace DREAMPLACE_NAMESPACE {
namespace cub = ::cub;
}
#else
// include cub in a safe manner
#define CUB_NS_PREFIX namespace DREAMPLACE_NAMESPACE {
#define CUB_NS_POSTFIX }
#define CUB_NS_QUALIFIER DREAMPLACE_NAMESPACE::cub
#include "cub/cub.cuh"
#undef CUB_NS_QUALIFIER
#undef CUB_NS_POSTFIX
#undef CUB_NS_PREFIX
#endif

#endif
