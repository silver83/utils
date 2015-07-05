#!/usr/bin/osascript

to splitString(aString, delimiter)
	set retVal to {}
	set prevDelimiter to AppleScript's text item delimiters
	set AppleScript's text item delimiters to {delimiter}
	set retVal to every text item of aString
	set AppleScript's text item delimiters to prevDelimiter
	return retVal
end splitString

on session_by_name(sessions, sess_name)
	repeat with sess in sessions
		log (name of sess) & " ?? " & sess_name
		if name of sess is equal to sess_name then return sess
	end repeat
	return 0
end session_by_name

on run argv

	tell application "iTerm"
		activate
		tell first window
			tell first tab
				activate

				set session_names to {Â
					"bus1", Â
					"bus2", Â
					"bus3", Â
					"discovery", Â
					"identity", Â
					"chat1", Â
					"chat2", Â
					"chat3", Â
					"presence1", Â
					"presence2", Â
					"presence3", Â
					"idsync" Â
				}

				--differentiating sockets used by the thousands digit
				--bus1=55143, bus2=56143, bus3=57143
				set session_cmd to {Â
					"rtservice bus -D bus.serviceMapStore=consul -D bus.id=1 -D log.suffix=1", Â
					"rtservice bus -D bus.serviceMapStore=consul -D bus.id=2 -D log.suffix=2 -D bus.manage.port=56290 -D bus.transports.socketio.port=56143", Â
					"rtservice bus -D bus.serviceMapStore=consul -D bus.id=3 -D log.suffix=3 -D bus.manage.port=57290 -D bus.transports.socketio.port=57143", Â
					"rtservice discovery", Â
					"rtservice identity", Â
					"rtservice chat -D log.suffix=1", Â
					"rtservice chat -D log.suffix=2 -D websocket.www.port=56143 -D chat.manage.port=56282", Â
					"rtservice chat -D log.suffix=3 -D websocket.www.port=57143 -D chat.manage.port=57282", Â
					"rtservice presence -D log.suffix=1", Â
					"rtservice presence -D log.suffix=2 -D websocket.www.port=56143 -D presence.manage.port=56281", Â
					"rtservice presence -D log.suffix=3 -D websocket.www.port=57143 -D presence.manage.port=57281", Â
					"rtservice idsync" Â
				}
				--bus original 55290
				--chat original 55282
				--presense original 55281

				set session_list to {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
				set sess_count to count of session_names


				repeat with sess in sessions
					tell sess
						select
						-- turn /dev/tty001 to tty001
						set stty to the tty of sess
						set stty to my splitString(tty as text, "/")
						set stty to item 3 of stty
						set stty to my splitString(stty as text, "ttys0")
						set stty to item 2 of stty
						set stty to stty as integer

						-- 000 -> 008
						if stty < sess_count then
							-- idx 1->9
							set idx to stty + 1
							set stty_name to item idx of session_names
							set name of sess to stty_name

							log "setting item " & (idx as text) & " to " & stty_name
							set item (stty + 1) of session_list to sess


							tell application "System Events"
								keystroke "c" using {control down}
								delay 0.2
								keystroke "k" using {command down}
							end tell
						end if
					end tell
				end repeat

				if (count of argv > 0 and (item 1 of argv is equal to "stop")) then
					return
				end if

				delay 3

				set idx to 1
				repeat with sess in session_list
					if (sess is not equal to 0) then
						set stty_name to item idx of session_cmd
						log (idx as text) & ". running '" & stty_name & "'"
						tell sess
							write text stty_name
						end tell
						set idx to idx + 1
						delay 0.5
					end if
				end repeat
			end tell
		end tell
	end tell
end run
