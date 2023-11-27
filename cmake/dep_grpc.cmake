
##
# @brief grpc
# @GIT_GRPC_REPOSITORY
# @GRPC_VERSION
# @GRPC_INSTALL_DIR
#
if (NOT GIT_GRPC_REPOSITORY)
    set(GIT_GRPC_REPOSITORY ${GITHUB_URL_PREFIX}https://github.com/grpc/grpc)
endif()
if (NOT GRPC_VERSION)
    set(GRPC_VERSION v1.58.2)
endif()

find_package(Threads REQUIRED)
FIND_OR_BUILD(
    TARGET gRPC
    GIT_URL ${GIT_GRPC_REPOSITORY}
    GIT_TAGS ${GRPC_VERSION}
    INSTALL_DIR ${GRPC_INSTALL_DIR}
    CMAKE_APPEND -DgRPC_BUILD_TESTS=OFF -DgRPC_MSVC_STATIC_RUNTIME=ON
    -DgRPC_SSL_PROVIDER=package -DBUILD_TESTING=OFF
)

function(GENERATE_GRPC)
    set(_options)
    set(_one_arg TARGET IMPORT_DIR)
    set(_multi_arg PROTO_SRC)
    CMAKE_PARSE_ARGUMENTS(_prefix "${_options}" "${_one_arg}" "${_multi_arg}" ${ARGN})
    set(_unuse_list ${_prefix_UNPARSED_ARGUMENTS})
    set(_target ${_prefix_TARGET})
    set(_import_dir ${_prefix_IMPORT_DIR})
    set(_proto_src ${_prefix_PROTO_SRC})

    add_library(${_target} OBJECT "${_proto_src}")

    target_link_libraries(${_target} PUBLIC protobuf::libprotobuf gRPC::grpc++)

    set(PROTO_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/")
    set(PROTO_IMPORT_DIRS "${CMAKE_CURRENT_LIST_DIR}/${_import_dir}")

    target_include_directories(${_target} PUBLIC "$<BUILD_INTERFACE:${PROTO_BINARY_DIR}>")

    protobuf_generate(
        TARGET ${_target}
        IMPORT_DIRS ${PROTO_IMPORT_DIRS}
        PROTOC_OUT_DIR "${PROTO_BINARY_DIR}")

    protobuf_generate(
        TARGET ${_target}
        LANGUAGE grpc
        GENERATE_EXTENSIONS .grpc.pb.h .grpc.pb.cc
        PLUGIN "protoc-gen-grpc=\$<TARGET_FILE:gRPC::grpc_cpp_plugin>"
        IMPORT_DIRS ${PROTO_IMPORT_DIRS}
        PROTOC_OUT_DIR "${PROTO_BINARY_DIR}")

endfunction()
