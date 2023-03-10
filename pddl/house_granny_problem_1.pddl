(define (problem robots-granny-house-problem)
  (:domain robots-granny-house)
  (:objects
    garage bathroom bedroom kitchen living_room - room
    doorA doorB doorC doorD - door
    tools clothes silverware towel - util
    tay - robot
    robot_gripper - gripper
    granny - human
  )
  (:init
    ; Robot at living room and granny in bedroom:
    (robot_at tay kitchen)
    (human_at granny bathroom)
    ; Robot's only gripper is free:
    (gripper_at robot_gripper tay)
    (gripper_free robot_gripper)
    ; Objests are in no corresponding rooms at the start:
    (object_at tools bathroom)
    (object_at clothes living_room)
    (object_at silverware living_room)
    (object_at towel kitchen)
    ; Declare map (Using "home" gazebo's map edited):
    (connected_by_door kitchen bathroom doorA)
    (connected_by_door bathroom kitchen doorA)
    (connected_by_door kitchen bedroom doorB)
    (connected_by_door bedroom kitchen doorB)
    (connected_by_door living_room garage doorC)
    (connected_by_door garage living_room doorC)
    (connected_by_door bedroom garage doorD)
    (connected_by_door garage bedroom doorD)

    (connected kitchen living_room)
    (connected living_room kitchen)
    ; All doors are closed:
    (open doorA)
    (close doorB)
    (close doorC)
    (open doorD)

    (close_door_request granny doorA)
  )

  (:goal
    (and
      ;Objects must be in their corresponding room:
      (move_object tools garage)
      (move_object towel bathroom)
      (move_object silverware kitchen)

      ; Human (in this case, granny) must be attended:
      (object_at towel bathroom)
      (object_at clothes bathroom)
      (close doorA)
      (human_attended granny)
    )
  )
)
