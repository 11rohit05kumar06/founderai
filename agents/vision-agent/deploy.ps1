# Run this script when Lemma is back up
# It updates vision-agent with the correct instruction and Groq-Fixed runtime profile

$instruction = Get-Content -Path "agents\vision-agent\instruction.md" -Raw

# Escape the instruction for JSON
$instruction = $instruction -replace '\\', '\\\\' -replace '"', '\"' -replace "`r`n", '\n' -replace "`n", '\n' -replace "`t", '\t'

$payload = "{`"name`":`"vision-agent`",`"description`":`"Refines a raw startup idea into a clear vision, mission, target audience, and value proposition.`",`"instruction`":`"$instruction`",`"toolsets`":[`"POD`"],`"visibility`":`"POD`",`"agent_runtime`":{`"profile_id`":`"019f10d2-43ee-7226-ba89-aed03fa4ef49`"},`"permissions`":{`"grants`":[{`"resource_type`":`"datastore_table`",`"resource_name`":`"startups`",`"permission_ids`":[`"datastore.table.read`",`"datastore.record.read`",`"datastore.record.write`"]}]}}"

[System.IO.File]::WriteAllText("$PWD\temp-agent.json", $payload, [System.Text.UTF8Encoding]::new($false))

lemma agents update vision-agent -f temp-agent.json

Write-Host "Done! Now test with:"
Write-Host 'lemma --timeout 60 agents run vision-agent "Build an AI fitness coach for college students"'
