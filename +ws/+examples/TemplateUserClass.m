classdef TemplateUserClass < ws.UserClass

    % This is a very simple user class.  It writes to the console when
    % things like a sweep start/end happen,
    
    % Information that you want to stick around between calls to the
    % functions below, and want to be settable/gettable from the command
    % line.
    properties
        Parameter1
        Parameter2
    end  % properties

    % Information that only the methods need access to.  (The underscore is
    % optional, but helps to remind you that it's protected.)
    properties (Access=protected, Transient=true)
        SomethingPrivateAndTemporary_
    end    
    
    methods        
        function self = TemplateUserClass(wsModel)
            % creates the "user object"
            fprintf('Instantiating an instance of TemplateUserClass.\n');
            self.Parameter1 = pi ;
            self.Parameter2 = exp(1) ;            
        end
        
        % These methods are called in the frontend process
        function startingRun(self,wsModel,eventName)
            % Called just before each set of sweeps (a.k.a. each
            % "run")
            fprintf('About to start a run.\n');
        end
        
        function startingSweep(self,wsModel,eventName)
            % Called just before each sweep
            fprintf('About to start a sweep.\n');
        end
        
        function completingSweep(self,wsModel,eventName)
            % Called after each sweep completes
            fprintf('Finished a sweep.\n');
        end
        
        function didStopSweep(self,wsModel,eventName)
            % Called if a sweep goes wrong
            fprintf('User stopped a sweep.\n');
        end        
        
        function didAbortSweep(self,wsModel,eventName)
            % Called if a sweep goes wrong
            fprintf('Oh noes!  A sweep aborted.\n');
        end        
        
        function didCompleteRun(self,wsModel,eventName)
            % Called just after each set of sweeps (a.k.a. each
            % "run")
            fprintf('Finished a run.\n');
        end
        
        function didStopRun(self,wsModel,eventName)
            % Called if a sweep goes wrong
            fprintf('User stopped a run.\n');
        end        
        
        function didAbortRun(self,wsModel,eventName)
            % Called if a run goes wrong, after the call to
            % didAbortSweep()
            fprintf('Oh noes!  A run aborted.\n');
        end
        
        function dataAvailable(self,wsModel,eventName)
            % Called each time a "chunk" of data (typically 100 ms worth) 
            % is read from the DAQ board.
            analogData = wsModel.Acquisition.getLatestAnalogData();
            digitalData = wsModel.Acquisition.getLatestRawDigitalData(); 
            nScans = size(analogData,1);
            fprintf('Just read %d scans of data.\n',nScans);                                    
        end
        
        % These methods are called in the looper process
        function samplesAcquired(self,wsModel,eventName)
            % Called each time a "chunk" of data (typically 100 ms worth) 
            % is read from the DAQ board.
            analogData = wsModel.Acquisition.getLatestAnalogData();
            digitalData = wsModel.Acquisition.getLatestRawDigitalData(); 
            nScans = size(analogData,1);
            fprintf('Just read %d scans of data.\n',nScans);                                    
        end
        
        % These methods are called in the refiller process
        function willPerformEpisode(self,wsModel,eventName)
            % Called just before each episode
            fprintf('About to start an episode.\n');
        end
        
        function didCompleteEpisode(self,wsModel,eventName)
            % Called after each episode completes
            fprintf('Finished an episode.\n');
        end
        
        function didStopEpisode(self,wsModel,eventName)
            % Called if a episode goes wrong
            fprintf('User stopped an episode.\n');
        end        
        
        function didAbortEpisode(self,wsModel,eventName)
            % Called if a episode goes wrong
            fprintf('Oh noes!  An episode aborted.\n');
        end
    end  % methods
    
end  % classdef

