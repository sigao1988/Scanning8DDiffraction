classdef EM4DData < matlab.mixin.Copyable
    
    properties
        data
        dataSize
        trans
        emTags
    end
    
    methods
        function obj = EM4DData( )
            obj.data = [];
            obj.dataSize = [];
            obj.trans = [];
            obj.emTags =  EMTags();
        end

    end
end

