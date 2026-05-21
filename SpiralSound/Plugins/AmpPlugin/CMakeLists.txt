
defplugin(AmpPlugin
    AmpPlugin.C AmpPluginGUI.C
)

target_sources(SpiralPlugin PUBLIC
    FILE_SET ampPlugin_HEADERS
    TYPE HEADERS
    BASE_DIRS
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    FILES
        AmpPlugin.h
        AmpPluginGUI.h
        SpiralIcon.xpm
)
