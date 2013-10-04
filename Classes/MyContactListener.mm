//
//  MyContactListener.mm
//  BounceCat
//
//  Created by Ivan on 2/24/13.
//
//

#import "MyContactListener.h"
#import "GroupsLevelsCore.h"

MyContactListener::MyContactListener() : _contacts() {
}


MyContactListener::~MyContactListener() {
}

void MyContactListener::BeginContact(b2Contact* contact) {
    // We need to copy out the data because the b2Contact passed in
    // is reused.
    MyContact myContact = { contact->GetFixtureA(), contact->GetFixtureB(), contact->GetManifold() };
    _contacts.push_back(myContact);
}

void MyContactListener::EndContact(b2Contact* contact) {
    MyContact myContact = { contact->GetFixtureA(), contact->GetFixtureB(), contact->GetManifold() };
    std::vector<MyContact>::iterator pos;
    pos = std::find(_contacts.begin(), _contacts.end(), myContact);
    if (pos != _contacts.end()) {
        _contacts.erase(pos);
    }
}

void MyContactListener::PreSolve(b2Contact* contact,
                                 const b2Manifold* oldManifold) {
    /**
     check if we need to set lower paddle opacity
     */
    [levelLayer resolvePaddleCollision:contact];
}

void MyContactListener::PostSolve(b2Contact* contact,
                                  const b2ContactImpulse* impulse) {
}
