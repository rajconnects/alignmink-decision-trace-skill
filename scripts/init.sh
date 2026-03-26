#!/bin/bash
# Alignmink Decision Trace Capture — Directory Initialization
# Run this once to set up the local storage structure.

TRACE_DIR="${1:-$(pwd)/alignmink-traces}"

echo "Initializing Alignmink traces at: $TRACE_DIR"

mkdir -p "$TRACE_DIR/threads"
mkdir -p "$TRACE_DIR/sessions"

# Create DECISIONS.md if it doesn't exist
if [ ! -f "$TRACE_DIR/DECISIONS.md" ]; then
  cat > "$TRACE_DIR/DECISIONS.md" << 'EOF'
# Decision Traces
> Captured by Alignmink Decision Trace Capture
> Every decision leaves a trace.

## Open Decisions

| Date | Decision | Category | Status | Participants |
|------|----------|----------|--------|--------------|

## Resolved Decisions

| Date | Decision | Category | Resolution | Participants |
|------|----------|----------|------------|--------------|

## Deferred Decisions

| Date | Decision | Category | Revisit Trigger | Participants |
|------|----------|----------|-----------------|--------------|

---
*Upgrade to [Alignmink StratOS](https://alignmink.ai) for team-wide decision capture, strategy alignment checking, and cross-company pattern matching.*
EOF
  echo "Created DECISIONS.md"
fi

echo ""
echo "Alignmink traces directory ready."
echo "  Threads:  $TRACE_DIR/threads/"
echo "  Sessions: $TRACE_DIR/sessions/"
echo "  Index:    $TRACE_DIR/DECISIONS.md"
echo ""
echo "Start a session in Claude Cowork: 'Start a decision capture session'"
