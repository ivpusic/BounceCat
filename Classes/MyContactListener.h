//
//  MyContactListener.h
//  BounceCat
//
//  Created by Ivan on 2/24/13.
//
//

#import "Box2D.h"
#import <vector>
#import <algorithm>

@class GroupsLevelsCore;

struct MyContact {
    b2Fixture *fixtureA;
    b2Fixture *fixtureB;
    b2Manifold *maniFoldInfo;
    b2Contact* contact;
    bool operator==(const MyContact& other) const
    {
        return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
    }
    };
    
    class MyContactListener : public b2ContactListener {
        
    public:
        std::vector<MyContact>_contacts;
        GroupsLevelsCore *levelLayer;
        MyContactListener();
        ~MyContactListener();
        
        virtual void BeginContact(b2Contact* contact);
        virtual void EndContact(b2Contact* contact);
        virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
        virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
        
    };
