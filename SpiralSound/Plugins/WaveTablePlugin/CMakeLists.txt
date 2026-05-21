
defplugin(WaveTablePlugin
    WaveTablePlugin.C WaveTablePluginGUI.C
)
target_link_libraries(WaveTablePlugin PUBLIC Fl_LED_Button Fl_Knob)
