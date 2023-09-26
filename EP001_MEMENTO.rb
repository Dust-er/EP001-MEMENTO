# EP002 M3M3NT0

use_synth :tb303
use_debug false

in_thread do
  use_synth :fm
  sleep 1
  loop do
    32.times do
      sample :drum_bass_hard, amp: 0.8
      sleep 0.25
      play :e2, release: 0.2
      sample :elec_cymbal, rate: 12, amp: 0.6
      sleep 0.25
    end
    sleep 4
  end
end


with_fx :reverb, room: 0.8 do
  live_loop :space_scanner do
    with_fx :slicer, phase: 0.25, amp: 1.5 do
      co = (line 70, 130, steps: 8).tick
      play :e1, cutoff: co, release: 14, attack: 2, cutoff_attack: 8, cutoff_release: 8
      sleep 8
    end
  end
  
  live_loop :squelch do
    use_random_seed 2023
    16.times do
      n = (ring :e2, :e3, :e4).tick
      play n, release: 0.125, cutoff: rrand(70, 130), res: 0.9, wave: 1, amp: 0.25
      sleep 0.125
    end
  end
end


use_synth :tb303
with_fx :reverb do |rev|
  loop do
    control rev, mix: rrand(0, 0.3)
    with_fx :slicer, phase: 0.125 do
      sample :ambi_lunar_land, sustain: 0, release: 8, amp: 2
    end
    
    control rev, mix: rrand(0, 0.6)
    r = rrand(0.05, 0.3)
    128.times do
      play chord(:e3, :minor).choose, release: r, cutoff: rrand(50, 90), amp: 0.5
      sleep 1
    end
    
  end
end

##|     control rev, mix: rrand(0, 0.6)
##|     r = rrand(0.1, 0.2)
##|     with_synth :prophet do
##|       8.times do
##|         sleep 0.125
##|         play chord(:a4, :m7).choose, release: r, cutoff: rrand(40, 130), amp: 0.7
##|       end
##|     end

##|     control rev, mix: rrand(0, 0.6)
##|     r = rrand(0.05, 0.3)
##|     8.times do
##|       play chord(:e3, :minor).choose, release: r, cutoff: rrand(110, 130), amp: 0.4
##|       sleep 0.125
##|     end

##|     control rev, mix: rrand(0, 0.6)
##|     with_fx :echo, phase: 0.25, decay: 8 do
##|       4.times do
##|         play chord([:e3, :e4, :e5].choose, :minor).choose, release: 0.05, cutoff: rrand(50, 129), amp: 0.5
##|         sleep 0.125
##|       end
##|     end
##|   end
##| end
