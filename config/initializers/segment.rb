Analytics = Segment::Analytics.new({
                                       write_key: '71qF3lDSi2BBo7Rodj42dlg2rlu8Aijn',
                                       on_error: Proc.new { |status, msg| print msg }
                                   })