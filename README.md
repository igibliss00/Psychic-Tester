# Psychic-Tester

An iOS app that demontrate the use case of view controller containment, CAEmitterLayer, IBDesignable, IBInspectable, and the WatchConnectivity framework.

<img src="https://github.com/igibliss00/Psychic-Tester/blob/master/README_assets/1.png" height="400">

## Features

### View Controller Containment

Why use view controller containment instead of just UIView?

* A view controller gets access to events like viewDidLoad and viewWillAppear, even when used as a child, which can be really useful for many kinds of UI code.
* A view controller is more self-contained — and can both include the logic required to drive its UI, as well as the UI itself.
* When added as a child, a view controller automatically fills the screen, reducing the need for additional layout code for full screen UIs.
* When a piece of UI is implemented as a view controller, it can be used in many different contexts — including both being pushed onto a navigation controller, as well as being embedded as a child.
* If there are too many responsibilities in one view controller, it violates the SRP (single Responsibility Principle).
* Easier to reuse a view controller with loosely coupled modules
* Easier to test each of the components

Adding and removing a view controller as a child requires three steps each:

#### Adding
```
let parent = UIViewController()
let child = UIViewController()

// First, add the view of the child to the view of the parent
parent.view.addSubview(child.view)

// Then, add the child to the parent
parent.addChild(child)

// Finally, notify the child that it was moved to a parent
child.didMove(toParent: parent)
```

#### Removing
```
// First, notify the child that it’s about to be removed
child.willMove(toParent: nil)

// Then, remove the child from its parent
child.removeFromParent()

// Finally, remove the child’s view from the parent’s
child.view.removeFromSuperview()
```

#### Reusable Extension

```
extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
/Users/jc/Downloads
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
```

([Source 1](https://www.swiftbysundell.com/basics/child-view-controllers/))
([Source 2](https://medium.com/appcoda-tutorials/avoiding-massive-view-controller-using-containment-child-view-controller-alfian-losari-98429158faf5))

In the current project, the individual cards are a view controller of their own and they are added as a child view controller to the root view controller:

```
let card = CardViewController()
card.delegate = self

// use view controller containment and also add the card's view to our cardContainer view
addChild(card)
cardContainer.addSubview(card.view)
card.didMove(toParent: self)
```

### CAEmitterLayer & CAEmitterCell

CAEmitterLayer is a layer that emits, animates, and renders a particle system.  The particles, defined by instances of CAEmitterCell, are drawn above the layer’s background color and border.  A good analogy, presented by [NSHipster](https://nshipster.com/caemitterlayer/), is that CAEmitterLayer is the confetti cannon and CAEmitterCell is the confetti.  CAEmitterLayer has the property to control the size, position, and intensity of the confetti cannon.  CAEmitterCell has a lot of properties, some of which are following:

* The birthRate property sets how many particles to create every second.
* The lifetime property sets how long each particle should live, in seconds.
* The velocity property sets the base movement speed for each particle.
* The velocityRange property sets how much velocity variation there can be.
* The emissionLongitude property sets the direction particles are fired.
* The spinRange property sets how much spin variation there can be between particles.
* The scale property sets how large particles should be, where 1.0 is full size.
* The scaleRange property sets how much size variation there can be between particles.
* The color property sets the color to be applied to each particle.
* The alphaSpeed property sets how fast particles should be faded out (or in) over their lifetime.
* The contents property assigns a CGImage to be used as the image.
([Source](https://www.hackingwithswift.com/read/37/5/creating-a-particle-system-using-caemitterlayer))

