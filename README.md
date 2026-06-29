# FounderAI

> Your AI co-founder team — turn a raw startup idea into a structured business foundation in minutes.

FounderAI is a multi-agent system built on the [Lemma](https://lemma.io) platform that replaces an early-stage startup team with specialized AI agents. Each agent owns a domain (vision, market research, branding, product, marketing, operations) and collaborates through a shared datastore, so insights compound instead of being lost in chat history.

---

## 🎯 Problem

First-time founders face an overwhelming, expensive, and fragmented process when turning a raw startup idea into a validated business. They must juggle vision crafting, market research, branding, product strategy, marketing, and operations — yet they cannot afford to hire experts for each role. Existing tools are siloed and generic AI chatbots produce shallow, disconnected outputs that don't compound into a coherent foundation.

## 💡 Solution

FounderAI gives every founder an **AI co-founder team** on day one:

- **Persistent memory** — every agent writes to a shared Lemma datastore
- **Specialized expertise** — each agent has a focused role and structured schema
- **Cross-functional coordination** — agents pass `startup_id`s to each other, building a connected business plan
- **Accessible** — no hiring, no per-seat licensing, no fragmented tools

---

## 🤖 The Agents

| Agent | Role | Output |
|---|---|---|
| **Vision Agent** | Visionary co-founder | Name, tagline, mission, vision, target audience, value proposition |
| **Market Research Agent** | Competitive intelligence | 3 real competitors with strengths, weaknesses, threat levels |
| **Branding Agent** *(coming soon)* | Brand strategist | Voice, tone, visual direction |
| **Product Manager Agent** *(coming soon)* | PM | MVP scope, feature roadmap |
| **Marketing Agent** *(coming soon)* | CMO | GTM plan, channels, positioning |
| **Operations Agent** *(coming soon)* | COO | Hiring plan, ops checklist |

All agents read and write to the central `startups` table, building a complete business blueprint as they run.

---

## 🏗️ Architecture
User Idea
│
▼
┌─────────────────┐
│ Vision Agent │ → creates row in startups (stage: ideation → validated)
└─────────────────┘
│ startup_id
▼
┌─────────────────────────┐
│ Market Research Agent │ → updates row with 3 competitors
└─────────────────────────┘
│ startup_id
▼
┌─────────────────┐
│ Branding Agent │ → updates row with brand identity
└─────────────────┘
│ ...continues

Every agent uses `pod_write_record` to persist its output, so the `startups` table grows into a complete business foundation for each idea.

---

## 🗂️ Repo Structure
founderai/
├── agents/
│ ├── vision-agent/
│ │ ├── vision-agent.json # agent manifest
│ │ └── instruction.md # detailed agent prompt
│ ├── market-research-agent/
│ ├── test-agent/
│ └── ... (more agents)
├── tables/
│ └── startups.json # datastore schema
└── README.md

---

## 🚀 Build Loop

### Validate before importing
lemma pods import ./founderai --dry-run
Push to Lemma
lemma pods import ./founderai
This upserts agents and tables by resource name.

⚙️ Setup (After Import)
Upload knowledge files (if any):
Bash

lemma files upload ./doc.pdf /pod/knowledge/doc.pdf
Connect external accounts:
Bash

lemma connectors ...
Activate schedules/surfaces once their targets exist.
✅ Verify It Works
Describe the pod
Bash

lemma pods describe
Run the Vision Agent
Bash

lemma agents chat vision-agent "AI fitness coach for college students with campus dining and class schedule integration"
Expected output: a startup_id plus a full vision (name, tagline, mission, vision, target audience, value proposition) written to the startups table.

Then run Market Research
Bash

lemma agents chat market-research-agent "startup_id: <id-from-vision> | research competitors"
Expected output: the startups row is updated with 3 real competitors.

🧪 Example Run
Input:

AI fitness coach for college students with campus dining and class schedule integration

Vision Agent output:

Name: QuadFit
Tagline: Train around your timetable. Eat with your meal plan.
Mission: QuadFit gives every college student a personal AI fitness and nutrition coach that adapts to their real class schedule and dining options.
Target Audience: Undergraduate and graduate students at U.S. colleges
Value Proposition: The only fitness app that knows both your schedule and your dining hall.
Market Research Agent output:

Freeletics (high threat — generic AI fitness, not campus-aware)
UniFit (high threat — direct campus-aware overlap)
Fitbod (medium threat — strength-only, no nutrition)
🛠️ Tech Stack
Lemma — agent orchestration platform
Lemma Pod Datastore — shared memory across agents
pod_write_record / pod_get_records — agent ↔ data interface
Web search toolset — for live competitor research
📌 Status
✅ Vision Agent — live
✅ Market Research Agent — live
🚧 Branding / Product / Marketing / Operations — in progress
🚧 Workflow orchestration — planned

👤 Operator
Built by Kotte Rohit Kumar on Lemma.

## 📝 How to Apply This

1. Open `D:\Rohit\founderai\README.md` in any text editor (Notepad, VS Code, etc.)
2. Replace the entire content with the markdown above
3. Save the file
4. Commit and push:
   powershell
   git add README.md
   git commit -m "Add proper README"
   git push
   
