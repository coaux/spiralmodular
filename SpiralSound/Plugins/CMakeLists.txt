
## SpiralPlugin dependencies derived from AmpPlugin/Makefile.in

defobject(SpiralPlugin
    SpiralPlugin.C
)

target_link_libraries(SpiralPlugin PUBLIC
    ${FLTK_LIBRARIES}
    Sample ChannelHandler SpiralGUI
)

defobject(SpiralPluginGUI
    SpiralPluginGUI.C
)

target_link_libraries(SpiralPluginGUI PUBLIC
    ChannelHandler SpiralGUI
)

target_sources(SpiralPlugin PUBLIC
    FILE_SET spiralPlugin_HEADERS
    TYPE HEADERS
    BASE_DIRS
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    FILES
        SpiralPlugin.h
        SpiralPluginGUI.h
)

add_subdirectory(Widgets)

if(SSM_ALL_PLUGINS)
    foreach(PLUGIN ${SSM_PLUGINS})
        add_subdirectory(${PLUGIN})
    endforeach()
else()
## temporary condition: Building only the plugins so-far ported
## to the new interface using boost-dll
    add_subdirectory(AmpPlugin)
    add_subdirectory(OutputPlugin)
    add_subdirectory(WaveTablePlugin)
    add_subdirectory(EnvelopePlugin)
    add_subdirectory(KeyboardPlugin)

    if(SSM_WITH_JACK)
    #  add_subdirectory(JackPlugin)
    endif()

    if(SSM_WITH_LADSPA)
    #  add_subdirectory(LADSPAPlugin)
    endif()
endif()
