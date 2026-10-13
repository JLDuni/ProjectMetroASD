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


## 4. Assumptions, Ambiguities, Inconsistencies and Missing Information
 
| AM-01 | A1 | Ambiguity | :
	Source in project description: "Schedules may vary according to the day of the week or other operational conditions"
	Issue: "Other conditions" is undefined.
	Decision / Assumption: Schedules vary by day type (weekday, Saturday, Sunday/holiday). Staff can define exceptions for specific dates.
 
| AM-02 | A2 | Ambiguity | :
	Source in project description: "scheduled trip"
	Issue: It is unclear whether this is a recurring template (line 12, 08:05) or a dated instance.
	Decision / Assumption: The model has a trip template and a dated trip instance. Delays, cancellations, occupancy and trip subscriptions apply to instances.
 
| AM-03 | A3 | Ambiguity | :
	Source in project description: "Ticket types may differ in price, period of validity, conditions of use, number of journeys"
	Issue: The set of types and the meaning of "conditions of use" are not given.
	Decision / Assumption: Ticket types are staff-managed data with attributes: price, validity period, max journeys (or unlimited) and optional line restriction. Seed examples: single, 10-journey, day pass, monthly pass.
 
| AM-04 | A7 | Ambiguity | :
	Source in project description: "Tickets must be validated when they are used"
	Issue: It is unclear where, and against which line or trip, validation happens.
	Decision / Assumption: A validation is a request (ticket id, trip instance id, timestamp, idempotency key) from a simulated validator. Validation is tied to a trip so it can feed occupancy.
 
| AM-05 | A8 | Ambiguity | :
	Source in project description: "previous validations … time at which it is used"
	Issue: There are no rules for re-validation, such as transfers within a time window.
	Decision / Assumption: Journey-count tickets consume one journey per accepted validation. Time-based passes are valid anywhere within their period. The same ticket validated again for the same trip is treated as a duplicate and not counted twice.
 
| AM-06 | A10 | Ambiguity | :
	Source in project description: "Occupancy … may be affected by ticket validations"
	Issue: There is no alighting data, so occupancy can only increase.
	Decision / Assumption: Occupancy = accepted validations on the trip instance. This is an upper-bound estimate, and staff can adjust it manually. Capacity per trip comes from a max-capacity attribute.
 
| AM-07 | A11 | Ambiguity | :
	Source in project description: FR16
	Issue: Only "Full" and "Low Occupancy" are given, and thresholds are not defined.
	Decision / Assumption: Three states: Low (<50%), Medium (50–89%), Full (≥90%). Thresholds are configurable.
 
| AM-08 | A12 | Ambiguity | :
	Source in project description: "update in real time" (FR6)
	Issue: No latency target.
	Decision / Assumption: Updates reach the passenger view within about 5 seconds (SSE or polling).
 
| AM-09 | A13 | Ambiguity | :
	Source in project description: "Disruptions may affect a complete line, individual stops, trips, or periods" vs. FR5–FR8
	Issue: The description is broader than the FRs, which are trip-level only.
	Decision / Assumption: A disruption has a scope (line, stop, trip or time period) and expands to the affected trip instances.
 
| AM-10 | A14 | Ambiguity | :
	Source in project description: FR6
	Issue: The recalculation rule is not specified.
	Decision / Assumption: The delay applies as a constant offset to all remaining stops of the trip, unless staff set per-stop delays.
 
| AM-11 | A15 | Ambiguity | :
	Source in project description: FR8
	Issue: Diversion details are not specified.
	Decision / Assumption: A diversion records the replacement sequence of stops or target line. Skipped stops show as "not served", and stops on the diversion show "diverted from line X".
 
| AM-12 | A20 | Ambiguity | :
	Source in project description: FR9 + FR20
	Issue: A passenger can match both rules, such as a ticket holder who also subscribed.
	Decision / Assumption: A passenger gets at most one notification per disruption event (deduplication key: user + disruption + type).
 
| AM-13 | A21 | Ambiguity | :
	Source in project description: FR18
	Issue: A trip subscription could be one dated instance or a recurring trip.
	Decision / Assumption: Both are supported: recurring (template) and specific date.
 
| AM-14 | A25 | Ambiguity | :
	Source in project description: "at least one supporting backend"
	Issue: The number and boundaries of components are open.
	Decision / Assumption: See section 6.
 
| AM-15 | A26 | Ambiguity | :
	Source in project description: "Handling of retries and duplicate messages"
	Issue: The delivery guarantee is not given.
	Decision / Assumption: At-least-once delivery with idempotent consumers. The effect happens once, even if a message arrives more than once.

----------------------------------------------------------------------------------------------------
| IN-01 | A9 | **Inconsistency** | :
	Source in project description: FR9 vs. ticket model
	Issue: Tickets are not bound to trips, so "active tickets matching the affected trip" is undefined.
	Decision / Assumption: "Matching" means one of two things. Either the ticket is active at the trip's time and permits the affected line, or the passenger has already validated on that trip. **Team decision needed.** Recommended: the first, with the second as a priority flag.
 
| IN-02 | A17 | **Inconsistency** | :
	Source in project description: FR1 vs. FR2–FR4
	Issue: Authentication is required only for sign-up, but consultation access is not stated.
	Decision / Assumption: Consultation (network, stops, schedules, trips) is public. Tickets, subscriptions and notifications require login.
 
----------------------------------------------------------------------------------------------------
| MI-03 | A6 | Missing info | :
	Source in project description: Tickets
	Issue: Refunds, transfers and cancellations are not mentioned.
	Decision / Assumption: Out of scope.
 
| MI-04 | A16 | Missing info | :
	Source in project description: Disruptions
	Issue: There is no end or resolution lifecycle.
	Decision / Assumption: Disruptions have start, end and status (active, resolved). Resolution also triggers an informational notification.
 
| MI-05 | A18 | Missing info | :
	Source in project description: Staff
	Issue: How staff accounts are created is not defined.
	Decision / Assumption: Role-based access (PASSENGER, STAFF). Staff accounts are provisioned by seed or admin, not by public sign-up.
 
| MI-06 | A19 | Missing info | :
	Source in project description: "Notify"
	Issue: Channels are not specified.
	Decision / Assumption: In-app notification stored per user, plus a simulated external channel (email or log). Delivery status is recorded.
 
| MI-07 | A22 | Missing info | :
	Source in project description: "Historical information may be relevant"
	Issue: There is no retention rule.
	Decision / Assumption: Records are never hard-deleted. Schedules, disruptions, tickets, validations and notifications are kept, with schedule changes versioned or marked inactive.
 
| MI-08 | A23 | Missing info | :
	Source in project description: Whole description
	Issue: Expected load and performance are not given.
	Decision / Assumption: Modest load (demo scale). Concurrency correctness matters more than throughput.
 
| MI-09 | A24 | Missing info | :
	Source in project description: Whole description
	Issue: Time zone and localization are not given.
	Decision / Assumption: All times are stored in UTC and displayed in Europe/Lisbon. Single language (English).

----------------------------------------------------------------------------------------------------

| MI-09 | A24 | Assumption | :
	Source in project description: xxxx
	Issue: xxxx
	Decision / Assumption: xxxx

## 5. Traceability to the Project Description
 
Source labels refer to the "Technical Description" section: **P1** network/schedules, **P2** disruptions, **P3** tickets, **P4** validation/staff usage info, **P5** occupancy, **P6** accounts/subscriptions, **P7** staff mechanisms, **P8** information lifecycles, **P9** resilience/idempotency. For the architecture sections: **ARCH**, **COMM**, **TEST**, **CICD**, **DEPLOY**, **AI**.
 
| Requirement | Source | Requirement | Source |
|---|---|---|---|
| FR1 | P6 | NFR1 | P9 |
| FR2 | P1 | NFR2 | P9, COMM |
| FR3 | P1 | NFR3 | P9, COMM |
| FR4 | P1 | NFR4 | ARCH |
| FR5 | P2 | NFR5 | DEPLOY |
| FR6 | P1 ("known changes"), P2 | NFR6 | COMM |
| FR7 | P2 | NFR7 | DEPLOY (monitoring), Phases |
| FR8 | P2 | NFR8 | CICD, TEST |
| FR9 | P2, P6 | | |
| FR10 | P3 | | |
| FR11 | P3 | | |
| FR12 | P3, P4 | | |
| FR13 | P4 | | |
| FR14 | P4 | | |
| FR15 | P5 | | |
| FR16 | P5 | | |
| FR17 | P5 | | |
| FR18 | P6 | | |
| FR19 | P6 | | |
| FR20 | P6 | | |
 
**Gaps (description statements with no requirement yet):**
- P7: staff maintaining network and schedules, managing ticket information, and registering disruptions.
- P2: disruptions at line, stop or period scope.
- P1: passenger information must reflect known changes.
- P8: historical information.
- ARCH: independent supporting service beyond notification.
- TEST, CICD, DEPLOY: integration/e2e tests, environments, secrets, versioned artifacts, traceability.
These are covered in the suggested changes in Appendix B.
 
## 6. Initial System Decomposition
 
**Style:** a web app, three backend services (one core, two supporting) and a message broker. Each service has its own database and is independently deployable as a container.
 
| Component | Responsibilities | Owns data |
|---|---|---|
| **Web App** | Passenger UI: consultation, tickets, subscriptions, notifications. Staff back-office: network, schedules, disruptions, ticket inspection, occupancy. | none |
| **Core Backend** | Authentication and roles (issues JWT). Network (lines, stops), schedules, trip instances. Disruption management and delay recalculation. Publishes disruption events. | users, lines, stops, schedules, trips, disruptions |
| **Ticketing & Occupancy Service** (supporting) | Ticket types, purchase, passenger wallet, expiry. Validation (atomic, idempotent). Validation history for staff. Occupancy and capacity calculation. | ticket types, tickets, validations, occupancy |
| **Notification Service** (supporting, independent boundary) | Subscriptions and preferences. Resolves affected passengers (subscriptions, plus ticket holders via event data). Deduplication, delivery, notification history. | subscriptions, preferences, notifications |
| **Message Broker** | Async event transport (e.g. RabbitMQ): `TripDelayed`, `TripCancelled`, `TripDiverted`, `DisruptionResolved`, `TicketPurchased`, `TicketExpired`. | none |
| **Observability** (cross-cutting) | Logs, health endpoints and metrics for every component (NFR7). | n/a |
 
**Interactions**
- **Sync (REST):** the Web App calls the Core and Ticketing services. Ticketing calls Core to check trip existence and capacity, with timeout, retry and cached fallback.
- **Async (events):** the Core publishes disruption events, which the Notification Service consumes. Ticketing publishes ticket events, which Notification consumes to know which passengers hold active tickets.
- **Failure isolation (NFR1):** if Notification is down, events queue in the broker and consultation still works. If Ticketing is down, the web app hides ticket and occupancy features but still shows the network and schedules.
- **Idempotency (NFR3):** the client sends an idempotency key for purchase and validation. Event consumers deduplicate by event id.
**Trade-off to justify:** keeping tickets and validation together avoids a distributed transaction around the "last journey" race. The cost is a larger service. Alternatively, merge ticketing into the Core, but then only Notification and Occupancy are separate.
 
## 7. LLM / AI Agent Usage Evidence (Milestone 1) 
 
Methodology ? ex: peer review on push / ci/cd validation /self-reviewing / AI peer review
 
| # | Date | Member | Tool/Model | Task | Prompt (link/summary) | LLM output summary | Human validation | Accepted / Modified / Rejected | Time spent |
|---|---|---|---|---|---|---|---|---|---|
| 1 | | | | extract FR/NFR from description | | || | |
| 2 | | | | rough buiding of software requirements  | | || | |
 
