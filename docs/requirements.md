# Software Requirements

## 1. Introduction

## 2. Functional Requirements(FR)

- **FR1 (Authentication):** Users of the WebApp must be able to sign up and sign in via email and password
- **FR2(Network Consultation):** The application should allow users to view transport network, including lines and stops
- **FR3(Stop details):** The system should allow users to view any bus stop and lines serving that stop
- **FR4(Stop Schedule):** The system should allow users to view departure and arrival time for a particular stop, filtered by day of the week
- **FR5(Real-Time Trip tracking):** The system should allow passengers to view specific scheduled trips and operational changes like delays, diversions or cancelations

- **FR6(Trip delays):** when a trip is delayed the system should reacalculate expected arrival times fpr remaining stops and update passengers consultation view in real time
- **FR7(Trip Cancelations):** when a trip is cancelled the system should mark subsequent stops or lines as cancelled for the duration of that trip 
- **FR8(Trip Diversion):** When a trip is diverted subsequent stops should display the line to where the trip was diverted
- **FR9(Trip Disruption Notification):** When a trip is delayed, cancelled or diverted the system should identify passengers with active tickets matching the affected trip and notify them

- **FR10(Ticket Acquisition):** The system should allow autenticated passengers to purchase tickets from the available types (differing by price, validity period, conditions of use, or number of permitted journeys)
- **FR11(Passenger Owned Tickets):** The system should allow passengers to view the tickets that are associated with their account displaying ticket status(Active, Expired) remaining validity period or permitted journeys
- **FR12(Ticket Revokation):** When the period of validity or the number of journeys permitted are expired the ticket must be marked as expired
- **FR13(Ticket Validation):** The system should validate the ticket upon each use verifying its active state, period of validity, permitted journeys and record succefull validations
- **FR14(Ticket Inspection):** Operational staff should be able to query the system for ticket usage data, active validations and validation history

- **FR15(Occupancy Monitoring):** The system should allow operational staff to verify real-time capacity, displaying maximum capacity limits
- **FR16(Passenger Capacity Monitoring):** When a passenger consults an upcoming trip the system should display capacity status(Full, Low Occupancy)
- **FR17(Capacity Calculations):** The system should dynamically calculate occupancy and remaining capacity of each trip based on ticket validations

- **FR18(Subscription):** The system should allow a passenger to subscribe/unsubscribe to a line, stop or scheduled trip 
- **FR19(Notification Preferences):** The system should allow passengers to configure their notifications preferences(delays, cancelations, diversions)
- **FR20(Subscriptions Notifications):** When an operational change or disruption occurs the system should notify all passengers whose subscription match line, stop or trip 

## 3. Non Functional Requirements(NFR)

- **NFR1(Component Isolation Failures):** Temporary component failures should not affect others , for example if notification component fails other components should work normaly 
- **NFR2(Communication/Network Failures):** Communication failures, timeouts, network failures should be handled gracefuly by the system
- **NFR3(Idempotency):** Operations such as purchasing a ticket, validating a ticket or sending an alert notification should not be executed more than once

- **NFR4(Multi-Component Architecture):** The system should be divided in multiple components, it should be decomposed at the very least as a web-application, a core backend, a notification component
- **NFR5(Containerization):** The system components must be containerized to ensure a consistent environment and deployment
- **NFR6(Communication Used):** The system should use synchronus communication(REST for request-reponse operations) and assynchronus communication for events/Alerts(Notifications)

- **NFR7(Monitoring Components):** Each component should provide logs, health status and observability mechanisms to detect failures
- **NFR8(Code-Base Changes):** Every code-base changes pushed to the repository should be automatically built, tested(at the very minimum unit tests) and analyzed with code quality tools
