% 														MIW 9


% Location  ISS(International Space Station)
iss.

% Modules
dockingHub.
controlModule.

% ControlModule
provision.
mainComputer.
cupola.

% Docking Hub
dockingArmsControllers.
controlPanel.
locker.
emergencyButton.

% Docking Hub Objects
spaceSuit.
spaceHelmet.
jetPack.
tools.

% Fact for all the modules
gateway. 

contain(iss, controlModule).
contain(iss, dockingHub).
contain(iss, gateway).

contain(dockingHub, dockingArmsControllers).
contain(dockingHub, emergencyButton).
contain(dockingHub, controlPanel).
contain(dockingHub, spaceHelmet).
contain(dockingHub, spaceSuit).
contain(dockingHub, jetPack).
contain(dockingHub, locker).
contain(dockingHub, tools).
contain(dockingHub, gateway).
contain(controlModule, cupola).
contain(controlModule, gateway).
contain(controlModule, provision).
contain(controlModule, mainComputer).

in(spaceHelmet, locker).
in(spaceSuit, locker).
in(jetPack, locker).
in(tools, locker).

right_after(emergencyButton, dockingArmsControllers).
right_after(dockingArmsControllers, emergencyButton).

right_after(gateway, dockingArmsControllers).
right_after(dockingArmsControllers, gateway).

right_after(controlPanel, emergencyButton).
right_after(emergencyButton, controlPanel).

right_after(provision, mainComputer).
right_after(mainComputer, provision).

right_after(locker, controlPanel).
right_after(controlPanel, locker).

right_after(mainComputer, cupola).
right_after(cupola, mainComputer).

right_after(cupola, gateway).
right_after(gateway, cupola).

%---------------------------------------------------------------------------------------------

%  Current location/ current position in a room
:- dynamic position/1.
:- dynamic loc/1.

% Initial loc and position
position(gateway).
loc(dockingHub).

current_module:-
    write('You are in Module: '), loc(X), write(X).

current_position:-
    write('Flying next to: '), position(X), write(X).
	
play_with(Object):-
    loc(X), contain(X, Object).

controlModule_to_Hub(PreviousObject, NewObject):-
	PreviousObject == gateway, NewObject == dockingArmsControllers
    ->  
    	retract(loc(_)),
    	assert(loc(dockingHub)),
    	write(' |! Control Module -> Docking Hub !| //  \n')
	;   write('').

hub_to_ControlModule(PreviousObject, NewObject):-
    PreviousObject == dockingArmsControllers, NewObject == gateway
    ->  
    	retract(loc(_)),
    	assert(loc(controlModule)),
    	write(' |! Docking Hub -> Control Module !| //  \n')
	;	write('').

teleport_to(Object):-
    position(X),
    right_after(X, Object)
    ->
    	position(X), write(X), write('->'), write(Object), write(' // \n'),
    	controlModule_to_Hub(X, Object),
    	hub_to_ControlModule(X, Object),
    	retract(position(_)),    		
    	assert(position(Object))
    ;   
    	position(X), write(X), write('X'), write(Object), write(' // \n').

/*	 
	teleport_to(dockingArmsControllers),
	teleport_to(emergencyButton),
	teleport_to(controlPanel),
	teleport_to(emergencyButton),
	teleport_to(dockingArmsControllers),
	teleport_to(gateway),
	teleport_to(cupola),
	teleport_to(mainComputer).
*/
