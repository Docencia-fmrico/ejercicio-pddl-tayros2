(define (domain robots-granny-house)
  (:requirements :typing :fluents :durative-actions :universal-preconditions :conditional-effects :continuous-effects)

  (:types
    room corridor - location
    robot gripper human door util
  )

  (:predicates
    (robot_at ?r - robot ?l - location)
    (object_at ?u - util ?l - location)
    (move_object ?u -util ?l - location)
    (human_at ?h - human ?l - location)

    (gripper_free ?g - gripper)
    (gripper_at ?g - gripper ?r - robot)
    (robot_carry ?r - robot ?g - gripper ?u - util)
    (connected ?l1 ?l2 - location)
    (connected_by_door ?l1 ?l2 - location ?d - door)
    (open ?d - door)
    (close ?d - door)

    (human_attended ?h - human)
    (close_door_request ?h - human ?d - door)
    (open_door_request ?h - human ?d - door)
    (pick_request ?h - human ?u - util)
  )

  (:action open-door
    :parameters (?r - robot ?l1 ?l2 - location ?d - door)
    :precondition (and
      (robot_at ?r ?l1)
      (close ?d)
      (connected_by_door ?l1 ?l2 ?d)
    )
    :effect (and
      (open ?d)
      (not (close ?d))
    )
  )

    (:action close-door
    :parameters (?r - robot ?l1 ?l2 - location ?d - door)
    :precondition (and
      (robot_at ?r ?l1)
      (open ?d)
      (connected_by_door ?l1 ?l2 ?d)
    )
    :effect (and
      (close ?d)
      (not (open ?d))
    )
  )
  

  (:action move_by_door
    :parameters (?r - robot ?from ?to - location ?d - door)
    :precondition (and
      (robot_at ?r ?from)
      (connected_by_door ?from ?to ?d)
      (open ?d)
    )
    :effect (and
      (not (robot_at ?r ?from))
      (robot_at ?r ?to)
    )
  )

  (:action move_without_door
    :parameters (?r - robot ?from ?to - location)
    :precondition (and
      (robot_at ?r ?from)
      (connected ?from ?to)
    )
    :effect (and
      (not (robot_at ?r ?from))
      (robot_at ?r ?to)
    )
  )

  (:action pick
    :parameters (?u - util ?l - location ?r - robot ?g - gripper)
    :precondition (and
      (gripper_at ?g ?r)
      (object_at ?u ?l)
      (robot_at ?r ?l)
      (gripper_free ?g)
    )
    :effect (and
      ;importantisimo indicar que el gancho deja de estar libre cuand empieza la accion
      (not (gripper_free ?g))
      (not (object_at ?u ?l))
      (robot_carry ?r ?g ?u)
    )
  )

  (:action drop
    :parameters (?u - util ?l - location ?r - robot ?g - gripper)

    :precondition (and
      (gripper_at ?g ?r)
      (robot_at ?r ?l)
      (robot_carry ?r ?g ?u)
    )
    :effect (and
      (gripper_free ?g)
      (object_at ?u ?l)
      (not (robot_carry ?r ?g ?u))
    )
  )

  (:action attend_pick_request
    :parameters (?u - util ?l - location ?r - robot ?g - gripper ?h - human)
    :precondition (and
      (pick_request ?h ?u)
      (object_at ?u ?l)
      (human_at ?h ?l)
    )
    :effect (and
      (not (pick_request ?h ?u))
      (human_attended ?h)
    )
  )

  (:action attend_open_door_request
    :parameters (?d - door ?h - human)
    :precondition (and
      (open_door_request ?h ?d)
      (open ?d)
    )
    :effect (and
      (not (open_door_request ?h ?d))
      (human_attended ?h)
    )
  )

  (:action attend_close_door_request
    :parameters (?d - door ?h - human)
    :precondition (and
      (close_door_request ?h ?d)
      (close ?d)
    )
    :effect (and
      (not (close_door_request ?h ?d))
      (human_attended ?h)
    )
  )

  (:action organize_object
    :parameters (?h - human ?u - util ?l - location)
    :precondition (and
      (human_attended ?h)
      (object_at ?u ?l)
    )
    :effect (and
      (move_object ?u ?l)
    )
    )
)
