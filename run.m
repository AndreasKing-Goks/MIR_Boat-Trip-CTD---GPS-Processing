clear all ; close all , clc
data1 = load('drifter_data_mod.mat') ;
model_data= load('Tbay_current_Wind_data.mat');
day = 1 ; % a value from the set {1 , 2 , 3}
drif= 1:7 ; % you can choose whatever number out of the 7 drifters 
depth = "Surface" ; 
dt = 1/60 ; 
t_mod = (day-1)* 24 ; 

start_time = data1.drifter_data_2021.deploy_time{day} ;
start_point = data1.drifter_data_2021.deploy_lat_long{day} ; 
end_time = data1.drifter_data_2021.retrieve_time{day} ; 

deploy_time= start_time(drif) + t_mod ;
ret_time = end_time(drif) + t_mod;
dep_lat = start_point(1,drif) ; 
dep_long = start_point(2,drif) ; 

d= {} ;
for i = 1: length(drif)
d{end+1} = plot_multi_drifters(dep_long(i), dep_lat(i), depth, model_data,  deploy_time(i), ret_time(i), dt );
end


d1_ncfiles= {'92110.nc', '53611.nc', '53368.nc' , '52052.nc' , '00390.nc' , '00386.nc', '00382.nc'}; 
d2_ncfiles= {'92110.nc', '84410.nc','53611.nc', '53368.nc' , '52052.nc' , '00390.nc' ,'00388.nc', '00386.nc', '00382.nc','00276.nc'}; 
d3_ncfiles = {'92110.nc','84410.nc', '53611.nc', '53368.nc' , '52052.nc' , '00390.nc' , '00386.nc', '00388.nc'} ;

if day == 1
    for i= 1:length(d1_ncfiles)
       longs = ncread(strcat('day1_2021','/',d1_ncfiles{i}), 'LONGITUDE') ;
       lats = ncread(strcat('day1_2021','/',d1_ncfiles{i}), 'LATITUDE') ;
       a = geoplot( lats,longs, 'y', 'MarkerSize', 12, 'LineWidth', 2 ) ;
       hold on
    
    end
elseif  day == 2
    for i= 1:length(d2_ncfiles)
       longs = ncread(strcat('day2_2021','/',d2_ncfiles{i}), 'LONGITUDE') ;
       lats = ncread(strcat('day2_2021','/',d2_ncfiles{i}), 'LATITUDE') ;
       a = geoplot( lats,longs, 'y', 'MarkerSize', 12, 'LineWidth', 2 ) ;
       hold on
    
    end
else 
    for i= 1:length(d3_ncfiles)
       longs = ncread(strcat('day3_2021','/',d3_ncfiles{i}), 'LONGITUDE') ;
       lats = ncread(strcat('day3_2021','/',d3_ncfiles{i}), 'LATITUDE') ;
       a = geoplot( lats,longs, 'y', 'MarkerSize', 12, 'LineWidth', 2 ) ;
       hold on
    
    end
end

for i = drif
    longs = d{i}.LONG;
    lats = d{i}.LAT ; 
    v= geoplot( lats,longs, 'r', 'MarkerSize', 12, 'LineWidth', 2 ) ;
end 
geolimits([43.06 43.13] , [ 5.96 6.0]) 
geobasemap satellite


legend([v, a],{'Simulated drifters' , '2021 drifters'}) 

