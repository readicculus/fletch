if(fletch_BUILD_WITH_CUDA)
  option(fletch_ENABLE_thundersvm_CUDA "Build thundersvm with CUDA support" TRUE )
  mark_as_advanced(fletch_ENABLE_thundersvm_CUDA)
else()
  unset(fletch_ENABLE_thundersvm_CUDA CACHE)
endif()

if(fletch_ENABLE_thundersvm_CUDA)
  set( thundersvm_GPU_ARGS -DUSE_CUDA:BOOL=ON -DUSE_EIGEN:BOOL=OFF)
else()
  set( thundersvm_GPU_ARGS -DUSE_CUDA:BOOL=OFF -DUSE_EIGEN:BOOL=ON)
endif()


# Main build and install command
ExternalProject_Add(thundersvm
  URL ${thundersvm_url}
  URL_MD5 ${thundersvm_md5}
  DOWNLOAD_NAME ${thundersvm_dlname}
  ${COMMON_EP_ARGS}
  ${COMMON_CMAKE_EP_ARGS}
  CMAKE_ARGS
    ${COMMON_CMAKE_ARGS}
    -DCMAKE_CXX_COMPILER:PATH=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER:PATH=${CMAKE_C_COMPILER}
  INSTALL_COMMAND ""
  )


fletch_external_project_force_install(PACKAGE thundersvm)

set(thundersvm_ROOT ${fletch_BUILD_INSTALL_PREFIX} CACHE STRING "")

file(APPEND ${fletch_CONFIG_INPUT} "
########################################
# thundersvm
########################################
set(thundersvm_ROOT    \${fletch_ROOT})
set(thundersvm_DIR     \${fletch_ROOT}/CMake)
set(fletch_ENABLED_thundersvm TRUE)
")
