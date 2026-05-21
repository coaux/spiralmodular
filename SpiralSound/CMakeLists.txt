
add_library(SpiralSound INTERFACE)

target_sources(SpiralSound PUBLIC
    FILE_SET spiralSound_HEADERS
    TYPE HEADERS
    BASE_DIRS
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    FILES
        ChannelHandler.h
        Midi.h
        NoteTable.h
        PluginManager.h
        RiffWav.h
        Sample.h
        SpiralInfo.h
)

defobject(ChannelHandler
    ChannelHandler.C
)

defobject(Midi
    Midi.C
)

defobject(NoteTable
    NoteTable.C
)

defobject(PluginManager
    PluginManager.C
)

defobject(RiffWav
    RiffWav.C
)

defobject(Sample
    Sample.C
)

defobject(SpiralInfo
    SpiralInfo.C
)

add_subdirectory(Plugins)

target_link_libraries(PluginManager PUBLIC
    SpiralInfo SpiralPlugin ${FLTK_LIBRARIES}
)
