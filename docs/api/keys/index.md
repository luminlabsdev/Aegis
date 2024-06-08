---
layout: home

hero:
  text: Key
  tagline: Used to specify something to the instance.

prev: "Spring"

features:
  - title: Children
    details: Adds descendant instances to parent instance.
    link: /api/keys/children

  - title: Ref
    details: Sets the instance to the reference state.
    link: /api/keys/ref

  - title: Events
    details: Connects the specified events to the instance.
    link: /api/keys/events

  - title: Changes
    details: Tracks changes of a property change of the instance.
    link: /api/keys/changes

  - title: Attributes
    details: Creates attributes of the instance.
    link: /api/keys/attributes

  - title: Tags
    details: Specifies tags to the instance.
    link: /api/keys/tags
---

## Properties

- **KeyName:** `string`\
  Name of the key **_(has to be unique)_**

## Functions

- **ApplyKey:** `(instance: Instance, value: any) -> ()`\
  This function will be called when the properties of the instance is applied.
