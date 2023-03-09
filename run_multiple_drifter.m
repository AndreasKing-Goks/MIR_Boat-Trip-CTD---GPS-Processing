clear all ; close all , clc
data1 = load('2021-drifter.mat') ;
model_data= load('Tbay_current_Wind_data.mat');
day = 1 ; % a value from the set {1 , 2 , 3}
drif= 1:7 ; % you can choose whatever number out of the 7 drifters 
depth = "Surface" ; 
dt = 1/60 ; 

start_time = data1.deploy_time{day} ;
start_point = data1.deploy_lat_long{day} ; 
end_time = data1.retrieve_time{day} ; 

deploy_time= start_time(drif) ;
ret_time = end_time(drif) ;
dep_lat = start_point(1,drif) ; 
dep_long = start_point(2,drif) ; 

simulate_drifters_q(dep_long, dep_lat, depth, model_data,  deploy_time, ret_time, dt )

xlabel('Longitude')
ylabel('Latitude')

legend('virtual drifter trajectory')