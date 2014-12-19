{
  "displayName": "Cura PLA MD",
  "description": "Print profile Cura PLA MD",
  "key": "medium_bq",
  "default": true,
  "data": {
    "fan_speed_max": 100,
    "end_gcode": [
      "\n; -- END GCODE --\nM104 S0                     ;extruder heater off\nM140 S0                     ;heated bed heater off (if you have it)\nG90\n;G91                                    ;relative positioning\nG1 E-5 F300                            ;retract the filament a bit before lifting the nozzle, to release some of the pressure\nG1 Z200 F{travel_speed} ;move Z up a bit and retract filament even more\nG28 X0 Y0                              ;move X/Y to min endstops, so the head is out of the way\nM84                         ;steppers off\nG90                         ;absolute positioning\n; -- end of END GCODE --",
      ";End GCode\nM104 T0 S0                     ;extruder heater off\nM104 T1 S0                     ;extruder heater off\nM140 S0                     ;heated bed heater off (if you have it)\n\nG91                                    ;relative positioning\nG1 E-1 F300                            ;retract the filament a bit before lifting the nozzle, to release some of the pressure\nG1 Z+0.5 E-5 X-20 Y-20 F{travel_speed} ;move Z up a bit and retract filament even more\nG28 X0 Y0                              ;move X/Y to min endstops, so the head is out of the way\n\nM84                         ;steppers off\nG90                         ;absolute positioning\n;{profile_string}\n",
      ";End GCode\nM104 T0 S0                     ;extruder heater off\nM104 T1 S0                     ;extruder heater off\nM104 T2 S0                     ;extruder heater off\nM140 S0                     ;heated bed heater off (if you have it)\n\nG91                                    ;relative positioning\nG1 E-1 F300                            ;retract the filament a bit before lifting the nozzle, to release some of the pressure\nG1 Z+0.5 E-5 X-20 Y-20 F{travel_speed} ;move Z up a bit and retract filament even more\nG28 X0 Y0                              ;move X/Y to min endstops, so the head is out of the way\n\nM84                         ;steppers off\nG90                         ;absolute positioning\n;{profile_string}\n",
      ";End GCode\nM104 T0 S0                     ;extruder heater off\nM104 T1 S0                     ;extruder heater off\nM104 T2 S0                     ;extruder heater off\nM104 T3 S0                     ;extruder heater off\nM140 S0                     ;heated bed heater off (if you have it)\n\nG91                                    ;relative positioning\nG1 E-1 F300                            ;retract the filament a bit before lifting the nozzle, to release some of the pressure\nG1 Z+0.5 E-5 X-20 Y-20 F{travel_speed} ;move Z up a bit and retract filament even more\nG28 X0 Y0                              ;move X/Y to min endstops, so the head is out of the way\n\nM84                         ;steppers off\nG90                         ;absolute positioning\n;{profile_string}\n"
    ],
    "cool_min_layer_time": 5,
    "skirt_line_count": true,
    "retraction_amount": 4,
    "travel_speed": 130,
    "raft_base_thickness": 0.3,
    "inner_shell_speed": 0.0,
    "print_temperature": [
      215,
      false,
      false,
      false
    ],
    "support": "none",
    "raft_margin": 5,
    "raft_base_linewidth": 0.7,
    "support_angle": 60,
    "raft_interface_linewidth": 0.2,
    "print_speed": 60,
    "infill_speed": 0.0,
    "support_fill_rate": 10,
    "retraction_min_travel": 1.5,
    "wipe_tower_volume": 15,
    "retraction_hop": 0.075,
    "retraction_speed": 40,
    "solid_top": true,
    "object_sink": false,
    "outer_shell_speed": 0.0,
    "solid_layer_thickness": 0.6,
    "fix_horrible_use_open_bits": false,
    "fix_horrible_union_all_type_a": true,
    "brim_line_count": 20,
    "nozzle_size": 0.4,
    "support_z_distance": 0.2,
    "skirt_minimal_length": 150.0,
    "overlap_dual": false,
    "support_dual_extrusion": "both",
    "raft_line_spacing": 1.0,
    "fan_full_height": false,
    "raft_interface_thickness": 0.2,
    "wall_thickness": 1.2,
    "start_gcode": [
      "\n; -- START GCODE --\n;Sliced at: {day} {date} {time}\n;Basic settings: Layer height: {layer_height} Walls: {wall_thickness} Fill: {fill_density}\n;Print time: {print_time}\n;Filament used: {filament_amount}m {filament_weight}g\n;Filament cost: {filament_cost}\n;M190 S{print_bed_temperature} ;Uncomment to add your own bed temperature line\n;M109 S{print_temperature} ;Uncomment to add your own temperature line\nG21        ;metric values\nG90        ;absolute positioning\nM107       ;start with the fan off\nG28 X0 Y0  ;move X/Y to min endstops\nG28 Z0     ;move Z to min endstops\nG1 Z15.0 F1200 ;move the platform down 15mm\nG92 E0                  ;zero the extruded length\nG1 F200 E5              ;extrude 5mm of feed stock\nG92 E0                  ;zero the extruded length again\nG1 F{travel_speed}\n;Put printing message on LCD screen\n;M117 Printing...\n; -- end of START GCODE --",
      ";Sliced at: {day} {date} {time}\n;Basic settings: Layer height: {layer_height} Walls: {wall_thickness} Fill: {fill_density}\n;M190 S{print_bed_temperature} ;Uncomment to add your own bed temperature line\n;M104 S{print_temperature} ;Uncomment to add your own temperature line\n;M109 T1 S{print_temperature2} ;Uncomment to add your own temperature line\n;M109 T0 S{print_temperature} ;Uncomment to add your own temperature line\nG21        ;metric values\nG90        ;absolute positioning\nM107       ;start with the fan off\n\nG28 X0 Y0  ;move X/Y to min endstops\nG28 Z0     ;move Z to min endstops\n\nG1 Z15.0 F{travel_speed} ;move the platform down 15mm\n\nT1                      ;Switch to the 2nd extruder\nG92 E0                  ;zero the extruded length\nG1 F200 E10             ;extrude 10mm of feed stock\nG92 E0                  ;zero the extruded length again\nG1 F200 E-{retraction_dual_amount}\n\nT0                      ;Switch to the first extruder\nG92 E0                  ;zero the extruded length\nG1 F200 E10             ;extrude 10mm of feed stock\nG92 E0                  ;zero the extruded length again\nG1 F{travel_speed}\n;Put printing message on LCD screen\nM117 Printing...\n",
      ";Sliced at: {day} {date} {time}\n;Basic settings: Layer height: {layer_height} Walls: {wall_thickness} Fill: {fill_density}\n;M190 S{print_bed_temperature} ;Uncomment to add your own bed temperature line\n;M104 S{print_temperature} ;Uncomment to add your own temperature line\n;M109 T1 S{print_temperature2} ;Uncomment to add your own temperature line\n;M109 T0 S{print_temperature} ;Uncomment to add your own temperature line\nG21        ;metric values\nG90        ;absolute positioning\nM107       ;start with the fan off\n\nG28 X0 Y0  ;move X/Y to min endstops\nG28 Z0     ;move Z to min endstops\n\nG1 Z15.0 F{travel_speed} ;move the platform down 15mm\n\nT2                      ;Switch to the 2nd extruder\nG92 E0                  ;zero the extruded length\nG1 F200 E10             ;extrude 10mm of feed stock\nG92 E0                  ;zero the extruded length again\nG1 F200 E-{retraction_dual_amount}\n\nT1                      ;Switch to the 2nd extruder\nG92 E0                  ;zero the extruded length\nG1 F200 E10             ;extrude 10mm of feed stock\nG92 E0                  ;zero the extruded length again\nG1 F200 E-{retraction_dual_amount}\n\nT0                      ;Switch to the first extruder\nG92 E0                  ;zero the extruded length\nG1 F200 E10             ;extrude 10mm of feed stock\nG92 E0                  ;zero the extruded length again\nG1 F{travel_speed}\n;Put printing message on LCD screen\nM117 Printing...\n",
      ";Sliced at: {day} {date} {time}\n;Basic settings: Layer height: {layer_height} Walls: {wall_thickness} Fill: {fill_density}\n;M190 S{print_bed_temperature} ;Uncomment to add your own bed temperature line\n;M104 S{print_temperature} ;Uncomment to add your own temperature line\n;M109 T2 S{print_temperature2} ;Uncomment to add your own temperature line\n;M109 T1 S{print_temperature2} ;Uncomment to add your own temperature line\n;M109 T0 S{print_temperature} ;Uncomment to add your own temperature line\nG21        ;metric values\nG90        ;absolute positioning\nM107       ;start with the fan off\n\nG28 X0 Y0  ;move X/Y to min endstops\nG28 Z0     ;move Z to min endstops\n\nG1 Z15.0 F{travel_speed} ;move the platform down 15mm\n\nT3                      ;Switch to the 4th extruder\nG92 E0                  ;zero the extruded length\nG1 F200 E10             ;extrude 10mm of feed stock\nG92 E0                  ;zero the extruded length again\nG1 F200 E-{retraction_dual_amount}\n\nT2                      ;Switch to the 3th extruder\nG92 E0                  ;zero the extruded length\nG1 F200 E10             ;extrude 10mm of feed stock\nG92 E0                  ;zero the extruded length again\nG1 F200 E-{retraction_dual_amount}\n\nT1                      ;Switch to the 2nd extruder\nG92 E0                  ;zero the extruded length\nG1 F200 E10             ;extrude 10mm of feed stock\nG92 E0                  ;zero the extruded length again\nG1 F200 E-{retraction_dual_amount}\n\nT0                      ;Switch to the first extruder\nG92 E0                  ;zero the extruded length\nG1 F200 E10             ;extrude 10mm of feed stock\nG92 E0                  ;zero the extruded length again\nG1 F{travel_speed}\n;Put printing message on LCD screen\nM117 Printing...\n"
    ],
    "skirt_gap": 3.0,
    "support_type": "lines",
    "fan_speed": 100,
    "support_xy_distance": 0.7,
    "platform_adhesion": "none",
    "bottom_layer_speed": 20,
    "wipe_tower": false,
    "solid_bottom": true,
    "retraction_combing": true,
    "layer_height": 0.2,
    "ooze_shield": false,
    "fan_enabled": true,
    "retraction_minimal_extrusion": 0.1,
    "fill_density": 20,
    "filament_diameter": [
      1.75,
      false,
      false,
      false
    ],
    "fill_overlap": 15,
    "fix_horrible_union_all_type_b": false,
    "retraction_dual_amount": 16.5,
    "spiralize": false,
    "print_bed_temperature": 70,
    "filament_flow": 100.0,
    "bottom_thickness": 0.2,
    "retraction_enable": true,
    "cool_min_feedrate": 10,
    "fix_horrible_extensive_stitching": false,
    "cool_head_lift": false
  }
}