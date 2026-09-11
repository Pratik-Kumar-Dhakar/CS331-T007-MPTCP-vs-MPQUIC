# AI Usage Documentation

## Tools

- Claude (Anthropic), used via the web/app interface throughout the project, from project topic selection onward.

## Thought Process

AI was used as a learning aid alongside the project from the very beginning, not brought in only at the end. The pattern throughout was: ask Claude to explain a concept, understand it, then explain it back in my own words so any gaps or misunderstandings could be corrected before moving on. This happened repeatedly, not just once, and several of the prompts below are exactly that: me checking whether I had understood something correctly, not me asking AI to do the work.

## Step-by-Step Details

1. **Project topic selection** - compared candidate Computer Networks project options against our team's constraints before settling on MPTCP vs MP-QUIC.
2. **Learning the core concepts** - before running any commands, had the mechanisms behind MPTCP explained in plain terms, then worked through my own understanding by explaining it back and getting corrected where I had it wrong.
3. **Hands-on setup and debugging** - built our own MPTCP test topology and ran the experiments ourselves; when results did not match expectations, shared the actual output and asked why, then re-ran it ourselves.
4. **Reading and understanding a teammate's research** - once a teammate compiled a research document, had it explained from the start in a teaching manner so I actually understood it well enough to present it, rather than just having skimmed it.
5. **Team-driven documentation requests** - as teammates asked for specific documentation (scheduling algorithms, kernel implementation history, named debates, theory vs practice gaps), used AI to research and structure this, cross-checked against the project's actual expected outcomes.

## Prompts Used (representative, in the order they came up)

- "Before we move forward, explain what is in there and what the project is actually about, in simple words. The meaning must not change."
- "Why do we even need multipath protocols? I understand it's for speed, but is it also that if we only have one path it can fail and the connection is lost, whereas with multiple paths the other can take over if one fails? But what if all paths fail?"
- "Is coupled congestion control a technique where, even though you're using two paths, you treat it like a single path instead of using both at full speed just because you have two? I feel like this is about not using both paths at the same time, is that right?"
- "What I understood is that if you consider both paths individually, they might share the same link deeper in the network and cause congestion there for other traffic. So instead of treating each path as independent, the whole connection is treated as having one fair share, and the window is set accordingly."
- "Let me explain what I understood so far before we continue. We created two paths between the host and the server, where the host is my computer and the server is something we set up ourselves. I see addresses like 10.0.0.2 and 10.0.1.1, what exactly is an IP address for here, and what did you mean by loopback? Explain it simply so I can explain it to my teammates and professor, I want to actually understand this, not just copy code."
- "We'll do the PPT later. First, my teammate made a research document and I only read it superficially. Explain it to me from the start, as if teaching a student who will also present this in viva, so I properly understand it, not just remember it."
- "A middlebox is any device sitting between me and the server that isn't the server itself, like a firewall or NAT box. MPTCP hides its multipath signals inside TCP options, and since middleboxes are often suspicious of anything unfamiliar, they can silently break or rewrite the packet, which breaks the coordination and either falls back to single path or breaks entirely. This isn't something code can fix since it's a structural problem, is that correct?"
- "QUIC encrypts the data and its own control information, so a middlebox can't see the multipath instructions inside a QUIC packet at all, so there's no chance of it breaking anything. QUIC also runs over UDP, and middleboxes treat UDP much more simply, is that right?"
- "My team wants as much documentation as possible on MPTCP and MP-QUIC, including scheduling algorithms like minRTT and how they differ. Let's build our own documentation for the team based on the actual project description."
- "Apart from my teammate's sources, do your own research and find more relevant papers on MPTCP and MP-QUIC, find the key differences we actually want to show in the project, nothing extra."
- "My teammate asked for three things: how MPTCP is implemented internally in the OS, why it was developed with at least two named debates and papers if they exist, and the gap between MPTCP's theory and real-world practical fallbacks including scheduling algorithm performance. Please document this properly so I can send it to my teammate."
- "My teammate wants just the topics within MPTCP implementation, for the PPT, remove the hands-on part I did myself."
