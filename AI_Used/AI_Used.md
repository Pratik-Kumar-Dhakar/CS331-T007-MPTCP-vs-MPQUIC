# AI_Used

This document describes how AI (Claude) was used in the **MP-QUIC** portion of the project — theoretical understanding, library comparison, and reporting support. Other components of the project (e.g., the Mininet/NetEm practical setup and MPTCP work) were handled by other team members and are outside the scope of this document.

---

## 1. Tools

| Tool | Purpose |
|---|---|
| **Claude (Anthropic)** | Research assistance, concept explanation, structuring of study material, library/protocol comparison, and drafting support for the final report and presentation slides. No other AI tool was used for this part of the project. |

---

## 2. Prompts

Below are the core prompts used with Claude during this phase of the project. Several additional short follow-up prompts (clarifying questions, requests to expand a specific section, or asking for more detail on a sub-topic already introduced) were used in the same pattern as these but are not individually reproduced here for brevity.

**Prompt 1 — Figuring out what actually needs to be learned**
> Before we divide the work, I want to understand how big this project actually is. There are 4 of us, and the project spans MP-QUIC, MPTCP, Mininet/NetEm, experiments, metrics, and the final comparison.
> I don't want us to divide it now and later realize one person's part depends heavily on another's, or that we missed something important.
> Break the project down into all the major areas that need to be understood or done, and explain how they connect. Then suggest a reasonable way for 4 people to divide it while still making sure everyone understands enough of the full project to defend it during the presentation.
> Point out which topics we should learn together first before splitting up, and which can be studied independently.
> Assume we're starting with only basic networking knowledge, and make the roadmap detailed enough to use as our starting point.

**Prompt 2 — Requesting a theory-first learning resource**
> I am working on the project now i only plan to learn the theoretical part since for the prof understanding of the topic the clarity is more important than any demonstration
> I want you to create a very detailed file (it might be very big but you can add chunk by chunk) which explains to me each and every aspect of it. Every part of the project what i need to be doing understanding theoretical mathematical, practical
> Say this started on this this was the idea people dug into it tried this then faced this issue. Then they changed to this
> And i want this for all it would be preferred to have seperate files for each role leave the data presentation and the mininet one just the tquic and mptcp
> Assume i have no idea of the current infrastructure or the networks
> So and like a story so i connect understand and it is intuitive for me to work with.

**Prompt 3 — Scoping the practical plan to MP-QUIC only**
> For now only mpquic
> Project Description: Study and compare MP-QUIC and MPTCP protocols for applications like video streaming, file transfer, and VoIP, focusing on throughput, latency, and connection stability.
> Tools/Technologies: QUIC implementation: quic-go, Cloudflare's quiche MPTCP: Linux kernel MPTCP, Multipath-enabled iproute2 Network emulation: NetEm, Mininet Monitoring: iperf3, Wireshark
> Expected Outcomes: Measure throughput, latency, and reliability under different network conditions Analyze how each protocol handles packet loss and congestion Gain practical experience configuring multipath protocols Provide recommendations for protocol use based on application needs
> The project description and expected outcomes are provided
> I am now trying to work with one who was responsible for setting up mininet/Netem
> Not sure if they have done or not neither do i wanna rely on them
> I need you help to lay out a proper plan as to how do i proceed with the practical part of this project ?? for just the mpquic
> mptcp for later
> Ask any questions or doubts needed ?

**Prompt 4 — Requesting more foundational detail**
> could you be more elaborate in the steps i am not aware of such stuff
> At the very least what all is present so i am now aware what an NIC is and etc etc a self sustaining doc to understand and execute both at the same time.

**Prompt 5 — Verifying completeness of the practical/benchmarking coverage**
> And will this practical setup cover all the cases i should be checking upon to get very correct and accurate data and will it also benchmark on all the required metrics and also what has been asked

**Prompt 6 — Shifting focus to deep conceptual mastery and library comparison**
> What i need to do is the professor asked that this is aready been a lot worked on and is present in quite a lot of places i can read understand and then present the data
> I need to deepen my understanding so i can eventually tackel any question that comes up for MPQUIC
> If possible I want to compare between the libraries TQUIC, given above, etc and see what differences they have what trade offs and advantages do each have
> Then if needed and possible i also want to rerun the setups so i can run it locally to verify
> My understanding over MPQUIC should be complete from all aspects. Assume i do not know much except few basics.
> Ask anything before proceeding

**Final-stage prompt (reporting support)** — Once real experimental metrics/results had been obtained, Claude was given the actual data and asked to (a) explain the underlying reasons for the observed results, and (b) help draft the final report and presentation slides in the format required for submission.

---

## 3. Thought Process

The overall goal of using AI in this project was to accelerate **understanding of a topic the team had no prior background in**, not to replace the work itself. MP-QUIC/multipath networking involves layered concepts (transport protocols, congestion control, multipath scheduling, kernel vs. userspace implementations) that are not covered in typical coursework, so the reasoning behind each stage of AI use was:

1. **Scoping and division of labor** — Before splitting work among the 4 team members, AI was used to break the full project (MP-QUIC, MPTCP, Mininet/NetEm, experiments, metrics, final comparison) into its major interdependent areas, so the team could divide roles without discovering later that one person's part depended heavily on another's, or that something important had been missed.
2. **Division of labor** — Once the project was selected, the team split responsibilities by component (e.g., MP-QUIC study, MPTCP study, Mininet/NetEm setup). AI was used individually by each member to ramp up on their assigned area.
3. **Guided self-learning** — Because this is a research-heavy, less-documented area, AI was used the way a tutor or research assistant would be: pointing toward what to read, explaining unfamiliar terms and infrastructure concepts from first principles, and structuring a learning path rather than generating the underlying knowledge from nothing. The intent was explicitly theory-first: understanding *why* design decisions were made in MP-QUIC (and how they compare across implementations), not just running a demo.
4. **Iterative deepening** — This was a repeated loop: ask AI to explain a concept → identify gaps → ask follow-up/clarifying prompts → cross-check against what's actually being asked for in the project brief → repeat until the topic (MP-QUIC theory, protocol behavior, implementation trade-offs) could be explained independently, including anticipating likely professor questions.
5. **Synthesis and reporting** — Only after real results/data were obtained (from the team's own testing) was AI brought back in — this time to help interpret *why* the results looked the way they did, and to help format that interpretation into a report and slide deck matching the required submission structure.

At no point was AI used to fabricate results or replace the team's own experimentation; its role was concentrated in the research, comprehension, and documentation stages.

---

## 4. Step-by-Step Details — Where and How AI Contributed (MP-QUIC)

| Stage | What was done | Role of AI |
|---|---|---|
| **1. Project scoping and role division** | With 4 team members and a project spanning MP-QUIC, MPTCP, Mininet/NetEm, experiments, metrics, and the final comparison, needed to map out all major areas and their dependencies before splitting work, and decide what everyone should learn together vs. independently. | Asked Claude to break the project into its major areas, explain how they connect, and propose a reasonable 4-way division that still let everyone understand enough of the full project to defend it in the presentation. |
| **3. Foundational orientation** | Needed to understand basic networking infrastructure (e.g., what a NIC is, how multipath transport differs from single-path TCP/QUIC) before the protocol-specific material would make sense. | Asked Claude to build a self-contained explanation starting from fundamentals, assuming no prior networking background, so later material could be understood without external lookups. |
| **4. Historical/design context of MP-QUIC** | Wanted to understand *why* MP-QUIC exists — the original problem, early approaches, issues encountered, and how the design evolved. | Asked Claude to lay this out narratively (the problem → early attempts → limitations found → design changes), rather than as a flat spec dump, to make the material easier to retain and explain. |
| **5. Practical setup planning (own understanding, not execution)** | Needed to understand what a full practical MP-QUIC evaluation *would* involve (metrics, tools, test cases) even though the hands-on Mininet/NetEm execution was owned by another teammate. | Asked Claude to lay out the practical plan and confirm it would cover all relevant test cases and the required benchmarking metrics, so the theoretical understanding stayed grounded in what a real evaluation requires. |
| **6. Library/implementation comparison** | Needed to go beyond a single implementation and understand trade-offs across MP-QUIC libraries (e.g., quic-go, quiche, TQUIC). | Asked Claude to compare the libraries — design differences, maturity, performance trade-offs, and advantages/limitations of each — to build a complete, defensible understanding rather than knowledge tied to one implementation. |
| **7. Depth check / exam-readiness** | Wanted to be able to answer any question the professor might raise on MP-QUIC, not just present a summary. | Used AI iteratively to probe understanding, clarify ambiguous points, and fill gaps until the topic could be explained independently and from multiple angles (theoretical, mathematical/congestion-control, and practical). |
| **8. Reporting and presentation** | After the team's own experimental data/metrics were obtained, needed to explain the results and package everything into a final deliverable. | Given the actual results, Claude was asked to explain the likely causes behind the observed behavior, and to help draft the final report and presentation slides in the required submission format. |

**Note:** The physical Mininet/NetEm environment setup and execution, and the data presentation component, were handled by another team member and are intentionally excluded from this document, which covers only the MP-QUIC research and understanding stream.
