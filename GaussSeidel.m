classdef GaussSeidel<handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties 
        i = 1;
        roots= [];
        maxIterations = 50;
        eps =  0.00001;
        eqns= {};
        data = [];
        signF = 5;
        ExTime  = 0;
        precession =0;
    end
    
    methods 
        %constructor of the method
        function  obj = GaussSeidel(eqns, max, ep)
           obj.eqns = eqns;
           obj.maxIterations = max;
           obj.eps = ep;
        end
        %setter of the input function
        function obj = set.eqns(obj, eqn)
            obj.eqns = eqn;
        end
        %setting # of segnficant digits
        function obj = set.signF(obj, sign)
            obj.signF = sign;
        end
        %setting maximum itration
        function obj = set.maxIterations(obj, max)
            obj.maxIterations = max;
        end
        %setting epsnon
        function obj = set.eps(obj, ep)
            obj.eps = ep;
        end
        %getting the output data
        function a = getData(obj)
         a = obj.data;
        end
        
        function a = getMaxIterations(obj)
         a = obj.maxIterations;
        end
        function a = getEps(obj)
         a = obj.eps;
        end
        %getting execution time
        function a = getExTime(obj)
         a = obj.ExTime;
        end
        %dont know what the use of this??????????????
        function obj = cc(obj, in)
            obj.signF = in;
        end
        
        %number 8
        function presion = pre(obj)
		presion = obj.precession;
        end
        
        %each one search for his 
        function theoriticalError = theo(obj)
            theoriticalError = 8;
        end
        
        %x0 be our initial guesses and obj.eqn are the functions
       function obj = calc(obj,x)
        
           obj.eqns
           x
             tic;
            equationsToMatrix(sym(obj.eqns));
            [a,b] = equationsToMatrix(sym(obj.eqns));
            z=[];
            z=a;
            for ii=1 :size(a,2)
               a(1:size(a,2),ii)=z(ii,1:size(a,2))
               ii=ii+1;
            end
            obj.data(1,4:6)=1;
            %mainloop
            obj.i=1;
            last=[];
            e=[];
            while(true)
            
                if obj.i > obj.maxIterations
                    break;
                end
                last=x;
                for ii=1 :size(x,2)
                    x(ii)= (b(ii)- x(1:size(x,2))*(a(1:size(x,2),ii))+(x(ii)*a(ii,ii)))/a(ii,ii);
                    e(ii)=abs((x(ii)-last(ii))/x(ii)); 
                end
                
                obj.data(obj.i,1:size(x,2))=x;
                
                obj.data(obj.i,size(x,2)+1:2*size(x,2))=e;
                obj.i=obj.i+1;

            end
            obj.roots = x;
            obj.ExTime=toc;
            if(obj.i>1)
                for ii=1 :size(x,2)
                    
                    obj.precession(ii)=fix((2-log(abs(obj.data(obj.i-1,4)))+log(.5))*1)/1;
                end
            end
            obj.i=obj.i-1;
        end

    end
    
end

