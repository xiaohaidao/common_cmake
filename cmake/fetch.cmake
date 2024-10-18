macro(fetch_add_packet_macro name)
    include(FetchContent)
    FetchContent_Declare(
        ${name}
        ${ARGN}
        GIT_SHALLOW ON
        GIT_PROGRESS ON)
    FetchContent_MakeAvailable(${name})
    string(TOUPPER ${name} name)
    set(FETCHCONTENT_UPDATES_DISCONNECTED_${name} ON)
    # or set(FETCHCONTENT_FULLY_DISCONNECTED OFF)
endmacro()

function(fetch_add_packet)
    fetch_add_packet_macro(${ARGV})
endfunction()
