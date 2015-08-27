classdef SamplesBuffer < handle
    properties (SetAccess=immutable)
        bufferSizeInScans_
    end
    
    properties
        analogBuffer_
        digitalBuffer_
        nScansInBuffer_
        timeSinceRunStartAtStartOfBuffer_
    end
    
    methods
        function self = SamplesBuffer(nAnalogChannels,nDigitalChannels,bufferSizeInScans)
            % This buffer is intended to store raw (unscaled) data
            self.analogBuffer_ = zeros(bufferSizeInScans,nAnalogChannels,'int16') ;
            % This buffer will store "packed" digital data
            if nDigitalChannels<=8 ,
                digitalType = 'uint8' ;
            elseif nDigitalChannels<=16 ,
                digitalType = 'uint16' ;
            else %nActiveChannels<=32 ,
                digitalType = 'uint32' ;
            end
            self.digitalBuffer_ = zeros(bufferSizeInScans,1,digitalType) ;
            self.bufferSizeInScans_ = bufferSizeInScans ;
            self.nScansInBuffer_ = 0 ;
        end  % method
        
        function err = store(self, newAnalogData, newDigitalData, timeSinceRunStartAtStartOfNewData)
            nNewScans = size(newAnalogData,1) ;
            nScansInBufferOriginally = self.nScansInBuffer_ ;
            nScansInBufferOnExit = nNewScans+nScansInBufferOriginally ;
            if nScansInBufferOnExit > self.bufferSizeInScans_ ,
                err = MException('ws:bufferOverrun', ...
                                 'Samples buffer was overrun before it could be emptied') ;
            else
                if nScansInBufferOriginally==0 ,
                    self.timeSinceRunStartAtStartOfBuffer_ = timeSinceRunStartAtStartOfNewData ;
                end
                self.analogBuffer_(nScansInBufferOriginally+1:nScansInBufferOnExit,:) = newAnalogData ;
                self.digitalBuffer_(nScansInBufferOriginally+1:nScansInBufferOnExit,:) = newDigitalData ;
                self.nScansInBuffer_ = nScansInBufferOnExit ;
                err = [] ;
            end            
        end  % method
        
        function [analogData,digitalData,timeSinceRunStartAtStartOfBuffer] = empty(self) 
            nScansInBuffer = self.nScansInBuffer_ ; 
            analogData = self.analogBuffer_(1:nScansInBuffer,:) ; 
            digitalData = self.digitalBuffer_(1:nScansInBuffer,:) ; 
            timeSinceRunStartAtStartOfBuffer = self.timeSinceRunStartAtStartOfBuffer_ ;
            % zero-out the buffer
            self.nScansInBuffer_ = 0 ;
            self.timeSinceRunStartAtStartOfBuffer_ = [] ;
        end  % method
        
        function result = nScansInBuffer(self)
            result = self.nScansInBuffer_ ;
        end  % method
    end  % public methods
end  % classdef
