#!/bin/bash
# Team development layout
# window 0: vim
# window 1: agents (Amy, Kai, NFT agent - 3 panes)
# window 2: shell

WORK_DIR="$HOME/work/liquid-agents"
AMY_DIR="$WORK_DIR/liqag-team-agents/team/amy"
KAI_DIR="$WORK_DIR/liqag-team-agents/team/kai"
NFT_DIR="$WORK_DIR/liqag-team-agents/team/nft-agent"

# Get current session name
SESSION=$(tmux display-message -p '#S')

# window 0: vim
# Check if window 0 exists, if not create it
if ! tmux list-windows -t $SESSION | grep -q "^0:"; then
  tmux new-window -t $SESSION:0 -n vim -c $WORK_DIR
else
  # window 0 already exists, just rename it
  tmux rename-window -t $SESSION:0 vim
fi

# window 1: agents layout (3 panes: Amy, Kai, NFT agent)
# Check if window 1 exists
if tmux list-windows -t $SESSION | grep -q "^1:"; then
  # Window exists, rename and resize panes
  tmux rename-window -t $SESSION:1 agents

  # Resize bottom pane (Shared Terminal) to 5%
  tmux resize-pane -t $SESSION:1.3 -y 5%

  # Resize top 3 panes to 33% each
  tmux select-pane -t $SESSION:1.0
  tmux resize-pane -t $SESSION:1.0 -x 33%
  tmux select-pane -t $SESSION:1.1
  tmux resize-pane -t $SESSION:1.1 -x 33%
else
  # Create fresh window 1 with Amy
  tmux new-window -t $SESSION:1 -n agents -c $AMY_DIR

  # Split bottom 5% for shared terminal
  tmux split-window -v -p 5 -t $SESSION:1 -c $WORK_DIR

  # Select top pane and split horizontally for Kai
  tmux select-pane -t $SESSION:1.0
  tmux split-window -h -t $SESSION:1.0 -c $KAI_DIR

  # Split horizontally for NFT agent
  tmux split-window -h -t $SESSION:1.1 -c $NFT_DIR

  # Resize top 3 panes to 33% each
  tmux select-pane -t $SESSION:1.0
  tmux resize-pane -t $SESSION:1.0 -x 33%
  tmux select-pane -t $SESSION:1.1
  tmux resize-pane -t $SESSION:1.1 -x 33%
fi

# Set pane titles
tmux select-pane -t $SESSION:1.0 -T "Amy"
tmux select-pane -t $SESSION:1.1 -T "Kai"
tmux select-pane -t $SESSION:1.2 -T "NFT agent"
tmux select-pane -t $SESSION:1.3 -T "Shared Terminal"

# Start Claude in Amy pane (top-left)
#tmux send-keys -t $SESSION:1.0 "sudo launchctl asuser \$(id -u) sudo -u $USER claude" C-m

# Start Claude in Kai pane (top-right)
#tmux send-keys -t $SESSION:1.1 "sudo launchctl asuser \$(id -u) sudo -u $USER claude" C-m

# window 2: general shell
tmux new-window -t $SESSION:2 -n shell -c $WORK_DIR

# Select window 1 (agents) and top-left pane
tmux select-window -t $SESSION:1
tmux select-pane -t $SESSION:1.0
