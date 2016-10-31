function notify(mobile)
    if(nargin < 1)
        mobile = 0;
    end
    if(mobile)
        webread('https://maker.ifttt.com/trigger/spyder/with/key/ou3_qyIHH3IV22kLJrvLT_AJLLNR8PyUqu8dmZvIlGH');
    end
    
    system('osascript -e ''display notification "Done in Spyder" sound name "Sound Name"''')
end

