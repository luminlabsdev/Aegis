# Aegis vs React/Roact

In this section, we won't be talking much about performance related, but rather about the external complexity of react.

## Creating instances

When you create instances using react, it returns you a ReactElement, which contains more information. Aegis doesn't go that deep, it simply just returns the instance which reduces a whole lot of memory going to waste.

## Events and changes

React implements a rather longer and complex way to handle events where, even though it contains most of the events and changes you'd use, it makes things harder by implementing each and every name of events and changes and you'd have to choose from them. This isn't ideal, which is why Aegis gives introduces keys which are much more simple in both concept and performance.

## Animation

There is one **very** major problem with react, which is animation. It does not implement any animation systems itself, which is why you'd have to use other libraries like [Otter](https://github.com/Roblox/otter). Having to use an entirely separate library just to animate elements is not ideal, which is why Aegis has a bigger advantage by implementing a spring system itself!
