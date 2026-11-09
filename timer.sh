if [[ "$1" == "s" ]]; then
    actions=(
        '30 deep bends + sholder rolls'
        '30 neck rolls'
        '30 neck rolls (swap)'
        '60 neck pull'
        '60 neck pull (swap)'
        '30 arm swings (horizontal)'
        '60 cross shoulder'
        '60 cross shoulder (swap)'
        '60 overhead triceps'
        '60 overhead triceps (swap)'
        '30 deep bends + sholder rolls'
        '60 touch toes (feet wide)'
        '30 hold squat'
        '60 swing side to side'
        '60 touch one foot'
        '60 touch one foot (swap)'
        '60 touch toes (feet narrow)'
        '60 pop heels'
        '30 squat into touch toes (stretch)'
        '60 butterfly pose'
        '60 push hands on knees'
        '60 lean forward (back straight)'
        '60 lean forward (curl back)'
        '60 extend one leg to side + reach with opposite arm (look up)'
        '60 hurdler (both hands)'
        '60 extend one leg to side + reach with opposite arm (look up, swap)'
        '60 hurdler (both hands, swap)'
        '180 straddle'
        '30 knee hug'
        '45 knee to chest'
        '90 hamstring'
        '45 pull other leg to the side'
        '45 cross leg over'
        '45 knee to chest (swap)'
        '90 hamstring (swap)'
        '45 pull other leg to the side (swap)'
        '45 cross leg over (swap)'
        '60 figure four'
        '60 figure four (swap)'
        '60 lunging hip flexor'
        '60 drop other knee to ground keep leg horizontal'
        '60 bring foot closer to chest to bring head down'
        '60 lunging hip flexor (swap)'
        '60 drop other knee to ground keep leg horizontal (swap)'
        '60 bring foot closer to chest to bring head down (swap)'
        '180 pigeon pose'
        '60 make a c with your back'
        '60 childs pose with reach'
    )
elif [[ "$1" == "w" ]]; then
    actions=(
        '30 plank knee twists'
        '30 wide push-ups'
        '30 shoulder taps'
        '30 mountain climbers'
        '30 toe cross overs'
        '30 heel touches'
        '15 rest'
        '30 ab crunch'
        '30 russian twists'
        '30 burpees (no push-up)'
        '30 toe jumps'
        '30 lunge jumps'
        '15 rest'
        '30 oblique crunch'
        '30 oblique crunch (swap)'
        '30 rotating punch'
        '30 v ins'
        '30 plank ups'
        '30 lunge ups (backwards)'
        '30 lunge ups (backwards, swap)'
        '30 high knees'
    )
else
    actions=()
fi

for action in "${actions[@]}"; do
    set -- $action

    for (( i=$1; i>=1; i-- )); do
        if (( i > 6 )); then
            notify-send -h string:tag:timer "$i ${*:2}"
        else
            notify-send -h string:tag:timer -u critical "$i ${*:2}"
        fi

        sleep 1
    done
done
