function result = nOccurancesOfDeviceNameAndID(deviceNames,ids)
    % Determine how many occurances of each ID there are in a row vector of
    % IDs.  IDs are assumed to be natural numbers.  This is useful for
    % finding, for instance, when multiple channels are trying to use the
    % same terminal ID.
    n = length(deviceNames);
    assert(n == length(ids),'ws:DeviceNameTerminalIDsLengthMismatch','Number of device names does not match the number of terminal IDs');
    if n==0 ,
        result = zeros(1,0) ;  % want to guarantee a row vector, even if input is zero-length col vector
        return
    end
    
    result = arrayfun(@(deviceName,id) sum(strcmpi(deviceName{1},deviceNames) & ids == id),deviceNames,ids);
end
