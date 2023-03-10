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

  (:durative-action open-door
    :parameters (?r - robot ?l1 ?l2 - location ?d - door)
    :duration (= ?duration 1)
    :condition (and
      (at start(robot_at ?r ?l1))
      (at start(close ?d))
      (at start(connected_by_door ?l1 ?l2 ?d))
    )
    :effect (and
      (at end(open ?d))
      (at end(not (close ?d)))
    )
  )

  (:durative-action close-door
    :parameters (?r - robot ?l1 ?l2 - location ?d - door)
    :duration (= ?duration 1)
    :condition (and
      (at start(robot_at ?r ?l1))
      (at start(open ?d))
      (at start(connected_by_door ?l1 ?l2 ?d))
    )
    :effect (and
      (at end(close ?d))
      (at end(not (open ?d)))
    )
  )

  (:durative-action move_by_door
    :parameters (?r - robot ?from ?to - location ?d - door)
    :duration (= ?duration 1)
    :condition (and
      (at start(robot_at ?r ?from))
      (at start(connected_by_door ?from ?to ?d))
      (at start(open ?d))
    )
    :effect (and
      (at end(not (robot_at ?r ?from)))
      (at end(robot_at ?r ?to))
    )
  )

  (:durative-action move_without_door
    :parameters (?r - robot ?from ?to - location)
    :duration (= ?duration 1)
    :condition (and
      (at start(robot_at ?r ?from))
      (at start(connected ?from ?to))
    )
    :effect (and
      (at end(not (robot_at ?r ?from)))
      (at end(robot_at ?r ?to))
    )
  )

  (:durative-action pick
    :parameters (?u - util ?l - location ?r - robot ?g - gripper)
    :duration (= ?duration 1)
    :condition (and
      (at start(gripper_at ?g ?r))
      (at start(object_at ?u ?l))
      (at start(robot_at ?r ?l))
      (at start(gripper_free ?g))
    )
    :effect (and
      ;importantisimo indicar que el gancho deja de estar libre cuand empieza la accion
      (at start(not (gripper_free ?g)))
      (at end(not (object_at ?u ?l)))
      (at end(robot_carry ?r ?g ?u))
    )
  )

  (:durative-action drop
    :parameters (?u - util ?l - location ?r - robot ?g - gripper)
    :duration (= ?duration 1)
    :condition (and
      (at start(gripper_at ?g ?r))
      (at start(robot_at ?r ?l))
      (at start(robot_carry ?r ?g ?u))
    )
    :effect (and
      (at end(gripper_free ?g))
      (at end(object_at ?u ?l))
      (at end(not (robot_carry ?r ?g ?u)))
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
