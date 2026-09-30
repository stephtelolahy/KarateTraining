# Generates the zuki (tsuki) illustrations in Assets.xcassets.
# Usage: python3 scripts/zuki_illustrations.py <outdir>, then copy each <name>.svg into <name>.imageset.
import math, os, sys

INK = "#1E2430"
GI = "#FFFFFF"
GI_FAR = "#D5DAE1"
SKIN = "#E9BC93"
SKIN_FAR = "#C99A72"
ACCENT = "#D6332E"
BG = "#F3EFE6"
GROUND = 184

def pts(ps):
    return " ".join(f"{x:.1f},{y:.1f}" for x, y in ps)

def stroke(ps, w, color, cap="round"):
    return (f'<polyline points="{pts(ps)}" fill="none" stroke="{color}" '
            f'stroke-width="{w}" stroke-linecap="{cap}" stroke-linejoin="round"/>')

def outlined(ps, w, fill):
    return stroke(ps, w + 4, INK) + stroke(ps, w, fill)

def circle(c, r, fill, sw=2):
    return f'<circle cx="{c[0]:.1f}" cy="{c[1]:.1f}" r="{r}" fill="{fill}" stroke="{INK}" stroke-width="{sw}"/>'

def unit(a, b):
    dx, dy = b[0] - a[0], b[1] - a[1]
    d = math.hypot(dx, dy) or 1
    return dx / d, dy / d

# ---------- body parts ----------

def leg(p, far=False):
    hip, knee, ankle, toe = p
    out = outlined([hip, knee, ankle], 12, GI_FAR if far else GI)
    out += outlined([ankle, toe], 6, SKIN_FAR if far else SKIN)
    return out

def hand(kind, wrist, elbow, far=False):
    skin = SKIN_FAR if far else SKIN
    ux, uy = unit(elbow, wrist)
    if kind == "fist":
        c = (wrist[0] + ux * 4, wrist[1] + uy * 4)
        return circle(c, 6.5, skin)
    if kind == "vfist":  # tate: vertical fist, seen from the side
        c = (wrist[0] + ux * 4, wrist[1] + uy * 4)
        return (f'<rect x="{c[0]-5:.1f}" y="{c[1]-8:.1f}" width="10" height="16" rx="4" '
                f'fill="{skin}" stroke="{INK}" stroke-width="2"/>')
    if kind == "palm":  # teisho: wrist bent back, fingers up
        heel = (wrist[0] + ux * 5, wrist[1] + uy * 5)
        tip = (heel[0] - 1, heel[1] - 15)
        return outlined([heel, tip], 8, skin) + stroke([(heel[0]-3, heel[1]-4), (heel[0]+3, heel[1]-4)], 1.2, INK)
    return ""

def arm(p, far=False, kind="fist"):
    shoulder, elbow, wrist = p
    return outlined([shoulder, elbow, wrist], 11, GI_FAR if far else GI) + hand(kind, wrist, elbow, far)

def torso_side(hip, shoulder):
    out = outlined([hip, shoulder], 24, GI)
    # belt: dark band just above the hip, perpendicular to the torso axis
    ux, uy = unit(hip, shoulder)
    b0 = (hip[0] + ux * 2, hip[1] + uy * 2)
    b1 = (hip[0] + ux * 8, hip[1] + uy * 8)
    out += stroke([b0, b1], 28, INK, cap="butt")
    # belt tail
    t0 = (b1[0] + 10, b1[1] + 2)
    out += stroke([(b1[0] + 6, b1[1]), t0, (t0[0] + 3, t0[1] + 9)], 3, INK)
    return out

def torso_front(ls, rs, lh, rh):
    d = f'M{ls[0]},{ls[1]} L{rs[0]},{rs[1]} L{rh[0]},{rh[1]} L{lh[0]},{lh[1]} Z'
    out = f'<path d="{d}" fill="{GI}" stroke="{INK}" stroke-width="2" stroke-linejoin="round"/>'
    # lapels
    cx = (ls[0] + rs[0]) / 2
    out += stroke([(cx - 9, ls[1]), (cx + 4, ls[1] + 30)], 2, INK)
    out += stroke([(cx + 9, rs[1]), (cx - 2, rs[1] + 22)], 2, INK)
    # belt
    y = lh[1] - 6
    out += f'<rect x="{lh[0]-1}" y="{y}" width="{rh[0]-lh[0]+2}" height="7" fill="{INK}"/>'
    out += stroke([(cx + 2, y + 6), (cx - 3, y + 16)], 3, INK)
    out += stroke([(cx + 3, y + 6), (cx + 8, y + 15)], 3, INK)
    return out

def head(c, facing="right", r=12):
    x, y = c
    out = circle(c, r, SKIN)
    if facing == "front":
        a0, a1, sweep = 200, 340, 1
    elif facing == "right":
        a0, a1, sweep = -40, 150, 0
    else:  # left
        a0, a1, sweep = 220, 30, 1
    p0 = (x + r * math.cos(math.radians(a0)), y + r * math.sin(math.radians(a0)))
    p1 = (x + r * math.cos(math.radians(a1)), y + r * math.sin(math.radians(a1)))
    large = 1
    if facing == "front":
        large = 0
    out += (f'<path d="M{p0[0]:.1f},{p0[1]:.1f} A{r},{r} 0 {large} {sweep} {p1[0]:.1f},{p1[1]:.1f} Z" '
            f'fill="{INK}"/>')
    return out

# ---------- effects ----------

def arrowhead(tip, frm, size=7):
    ux, uy = unit(frm, tip)
    px, py = -uy, ux
    a = (tip[0] - ux * size + px * size * 0.6, tip[1] - uy * size + py * size * 0.6)
    b = (tip[0] - ux * size - px * size * 0.6, tip[1] - uy * size - py * size * 0.6)
    return f'<polygon points="{pts([tip, a, b])}" fill="{ACCENT}"/>'

def arrow(path_pts, curve=None, dashed=True):
    """Straight arrow through points, or quadratic curve with control point `curve`."""
    dash = ' stroke-dasharray="5 4"' if dashed else ""
    a, b = path_pts[0], path_pts[-1]
    if curve:
        d = f'M{a[0]},{a[1]} Q{curve[0]},{curve[1]} {b[0]},{b[1]}'
        frm = curve
    else:
        d = "M" + " L".join(f"{x},{y}" for x, y in path_pts)
        frm = path_pts[-2]
    # stop the line a bit before the tip so the head stays crisp
    return (f'<path d="{d}" fill="none" stroke="{ACCENT}" stroke-width="2.5" '
            f'stroke-linecap="round"{dash}/>' + arrowhead(b, frm))

def impact(fist, direction, n=3):
    """Short radiating lines in front of the striking hand."""
    ux, uy = direction
    d = math.hypot(ux, uy); ux, uy = ux / d, uy / d
    out = ""
    for ang in ([-35, 0, 35] if n == 3 else [-25, 25]):
        r = math.radians(ang)
        vx = ux * math.cos(r) - uy * math.sin(r)
        vy = ux * math.sin(r) + uy * math.cos(r)
        s = (fist[0] + vx * 12, fist[1] + vy * 12)
        e = (fist[0] + vx * 19, fist[1] + vy * 19)
        out += stroke([s, e], 2.5, ACCENT)
    return out

def ghost_head(c, r=12):
    return (f'<circle cx="{c[0]}" cy="{c[1]}" r="{r}" fill="none" stroke="{INK}" '
            f'stroke-width="1.5" stroke-dasharray="3 3" opacity="0.5"/>')

# ---------- fist orientation inset ----------

def inset(kind):
    """Small badge in the top-left corner showing the fist seen from the front."""
    cx, cy, R = 34, 34, 22
    out = f'<circle cx="{cx}" cy="{cy}" r="{R}" fill="#FFFFFF" stroke="{INK}" stroke-width="1.5" opacity="0.95"/>'
    def knuckles(vertical, thumb_side):
        o = ""
        if vertical:
            x, y, w, h = cx - 6, cy - 13, 12, 26
        else:
            x, y, w, h = cx - 13, cy - 6, 26, 12
        o += f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="4" fill="{SKIN}" stroke="{INK}" stroke-width="1.5"/>'
        for i in range(1, 4):
            if vertical:
                yy = y + h * i / 4
                o += stroke([(x, yy), (x + w, yy)], 1.2, INK)
            else:
                xx = x + w * i / 4
                o += stroke([(xx, y), (xx, y + h)], 1.2, INK)
        if thumb_side == "below":
            o += f'<rect x="{cx-11}" y="{cy+5}" width="12" height="6" rx="3" fill="{SKIN}" stroke="{INK}" stroke-width="1.5"/>'
        elif thumb_side == "above":
            o += f'<rect x="{cx-11}" y="{cy-11}" width="12" height="6" rx="3" fill="{SKIN}" stroke="{INK}" stroke-width="1.5"/>'
        elif thumb_side == "side":
            o += f'<rect x="{cx+5}" y="{cy-11}" width="6" height="12" rx="3" fill="{SKIN}" stroke="{INK}" stroke-width="1.5"/>'
        return o
    if kind == "down":
        out += knuckles(False, "below")
    elif kind == "vertical":
        out += knuckles(True, "side")
    elif kind == "up":
        out += knuckles(False, "above")
    return out

# ---------- stances (side view, facing right) ----------

def zenkutsu(dx=0, low=0):
    hip = (92 + dx, 116 + low)
    near = [hip, (122 + dx, 146), (126 + dx, 180), (140 + dx, 183)]
    far = [hip, (68 + dx, 148), (44 + dx, 179), (57 + dx, 184)]
    return hip, near, far

def short_stance(dx=0):
    hip = (96 + dx, 112)
    near = [hip, (118 + dx, 144), (122 + dx, 180), (136 + dx, 183)]
    far = [hip, (78 + dx, 146), (62 + dx, 179), (75 + dx, 184)]
    return hip, near, far

def natural():
    hip = (100, 108)
    near = [hip, (103, 144), (103, 180), (117, 183)]
    far = [hip, (97, 144), (97, 180), (111, 183)]
    return hip, near, far

def shadow(cx=96, w=64):
    return f'<ellipse cx="{cx}" cy="{GROUND + 1}" rx="{w}" ry="5" fill="{INK}" opacity="0.12"/>'

def hikite(sh, far=True):
    x, y = sh
    return [sh, (x - 27, y + 22), (x - 10, y + 40)]

def side_figure(stance, shoulder, head_c, near_arm=None, far_arm=None,
                near_kind="fist", far_kind="fist", extra_back="", extra_front=""):
    hip, near_leg, far_leg = stance
    far_sh = (shoulder[0] - 3, shoulder[1] + 1)
    out = extra_back
    out += shadow((near_leg[2][0] + far_leg[2][0]) / 2, 62)
    if far_arm:
        out += arm([far_sh] + far_arm, far=True, kind=far_kind)
    out += leg(far_leg, far=True)
    out += leg(near_leg)
    out += torso_side(hip, shoulder)
    out += head(head_c, "right")
    if near_arm:
        out += arm([shoulder] + near_arm, kind=near_kind)
    out += extra_front
    return out

def front_figure(stance="kiba", arms=(), head_facing="front", extra_back="", extra_front=""):
    if stance == "kiba":
        lh, rh = (86, 116), (114, 116)
        legs = [[(88, 112), (62, 144), (60, 180), (50, 183)],
                [(112, 112), (138, 144), (140, 180), (150, 183)]]
        top = 64
    else:  # heiko / natural, front view
        lh, rh = (87, 110), (113, 110)
        legs = [[(90, 106), (86, 144), (85, 180), (80, 183)],
                [(110, 106), (114, 144), (115, 180), (120, 183)]]
        top = 58
    ls, rs = (80, top), (120, top)
    out = extra_back + shadow(100, 58)
    for l in legs:
        out += leg(l)
    out += torso_front(ls, rs, lh, rh)
    out += head((100, top - 22), head_facing)
    for side, p, kind in arms:
        sh = ls if side == "L" else rs
        out += arm([sh] + p, kind=kind)
    out += extra_front
    return out

def svg(body, title):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200" width="200" height="200">'
            f'<title>{title}</title>'
            f'<rect x="0" y="0" width="200" height="200" rx="24" fill="{BG}"/>'
            f'<line x1="14" y1="{GROUND+1}" x2="186" y2="{GROUND+1}" stroke="{INK}" stroke-width="1.5" opacity="0.25"/>'
            f'{body}</svg>')

# ---------- techniques ----------

T = {}

# Choku-zuki: natural stance, straight punch chudan, other fist at the hip.
sh = (100, 62)
T["choku-zuki"] = ("Choku-zuki", side_figure(
    natural(), sh, (102, 40),
    near_arm=[(125, 67), (150, 72)], far_arm=hikite(sh)[1:],
    extra_front=impact((154, 72), (1, 0.15)) + inset("down")))

# Oi-zuki / Jun-zuki: step forward in zenkutsu, punch with the front-leg side.
st = zenkutsu()
sh = (96, 66)
T["oi-zuki"] = ("Oi-zuki", side_figure(
    st, sh, (99, 44),
    near_arm=[(121, 71), (146, 76)], far_arm=hikite(sh)[1:],
    extra_front=impact((150, 76), (1, 0.15)) + arrow([(30, 194), (136, 194)])))

# Gyaku-zuki: zenkutsu, punch with the rear-leg side, hips rotated.
sh = (97, 66)
T["gyaku-zuki"] = ("Gyaku-zuki", side_figure(
    st, sh, (100, 44),
    far_arm=[(119, 72), (145, 77)], near_arm=hikite(sh)[1:],
    extra_front=impact((149, 77), (1, 0.15))))

# Kizami-zuki: short stance, leaning in, front hand jodan.
st = short_stance()
sh = (104, 64)
T["kizami-zuki"] = ("Kizami-zuki", side_figure(
    st, sh, (108, 42),
    near_arm=[(127, 56), (151, 48)], far_arm=hikite(sh)[1:],
    extra_front=impact((155, 47), (1, -0.3))))

# Maete-zuki: front hand chudan, rear hand in guard.
st = short_stance(-4)
sh = (95, 62)
T["maete-zuki"] = ("Maete-zuki", side_figure(
    st, sh, (97, 40),
    near_arm=[(120, 67), (145, 72)], far_arm=[(100, 84), (114, 56)],
    extra_front=impact((149, 72), (1, 0.15))))

# Age-zuki: rising punch towards the chin.
st = zenkutsu()
sh = (96, 66)
T["age-zuki"] = ("Age-zuki", side_figure(
    st, sh, (99, 44),
    near_arm=[(119, 80), (135, 55)], far_arm=hikite(sh)[1:],
    extra_back=arrow([(120, 110), (152, 42)], curve=(162, 104)),
    extra_front=impact((137, 51), (0.4, -1), n=2)))

# Kagi-zuki: front view, kiba-dachi, hook punch parallel to the chest.
T["kagi-zuki"] = ("Kagi-zuki", front_figure(
    "kiba",
    arms=[("L", [(64, 90), (76, 108)], "fist"),
          ("R", [(140, 78), (104, 80)], "fist")],
    extra_front=arrow([(152, 96), (106, 96)], curve=(132, 108)) + impact((100, 80), (-1, 0), n=2)))

# Mawashi-zuki / Furi-zuki: circular punch from outside in, head level.
T["mawashi-zuki"] = ("Mawashi-zuki", front_figure(
    "heiko",
    arms=[("L", [(64, 82), (76, 102)], "fist"),
          ("R", [(144, 60), (108, 58)], "fist")],
    extra_back=arrow([(166, 100), (130, 52)], curve=(180, 46)),
    extra_front=impact((104, 58), (-1, 0), n=2)))

# Morote-zuki: both fists together, zenkutsu.
st = zenkutsu()
sh = (96, 66)
T["morote-zuki"] = ("Morote-zuki", side_figure(
    st, sh, (99, 44),
    near_arm=[(121, 73), (146, 80)], far_arm=[(118, 66), (143, 68)],
    extra_front=impact((151, 74), (1, 0.1))))

# Heiko-zuki: both fists parallel, natural stance.
sh = (100, 62)
T["heiko-zuki"] = ("Heiko-zuki", side_figure(
    natural(), sh, (102, 40),
    near_arm=[(125, 70), (150, 76)], far_arm=[(122, 60), (147, 60)],
    extra_front=arrow([(112, 50), (148, 48)], dashed=False) + arrow([(114, 90), (148, 90)], dashed=False)))

# Hasami-zuki: front view, two fists converge like scissors.
T["hasami-zuki"] = ("Hasami-zuki", front_figure(
    "kiba",
    arms=[("L", [(56, 82), (82, 90)], "fist"),
          ("R", [(144, 82), (118, 90)], "fist")],
    extra_back=arrow([(34, 106), (78, 102)], curve=(36, 76)) + arrow([(166, 106), (122, 102)], curve=(164, 76))))

# Morote-ura-zuki: both fists palm-up, rising, elbows close to the body.
st = zenkutsu(low=4)
sh = (100, 70)
T["morote-ura-zuki"] = ("Morote-ura-zuki", side_figure(
    st, sh, (104, 48),
    near_arm=[(106, 94), (133, 90)], far_arm=[(104, 88), (130, 72)],
    extra_front=arrow([(140, 108), (158, 84)], curve=(156, 106)) + inset("up")))

# Awase-zuki: fists at two levels, top jodan, bottom palm-up chudan.
st = zenkutsu()
sh = (96, 66)
T["awase-zuki"] = ("Awase-zuki", side_figure(
    st, sh, (99, 44),
    near_arm=[(120, 58), (145, 52)], far_arm=[(112, 88), (137, 92)],
    extra_front=impact((149, 51), (1, -0.2), n=2) + impact((142, 92), (1, 0.1), n=2)))

# Yama-zuki: body in profile, top arm arched jodan, bottom fist chudan below it.
st = zenkutsu(low=2)
sh = (100, 70)
T["yama-zuki"] = ("Yama-zuki", side_figure(
    st, sh, (106, 50),
    near_arm=[(116, 48), (140, 44)], far_arm=[(114, 94), (140, 98)],
    extra_front=impact((144, 44), (1, 0), n=2) + impact((144, 98), (1, 0), n=2)))

# Nagashi-zuki: dodge the attack while punching with the front hand.
st = zenkutsu(low=6)
sh = (106, 82)
T["nagashi-zuki"] = ("Nagashi-zuki", side_figure(
    st, sh, (108, 62),
    near_arm=[(131, 82), (156, 80)], far_arm=hikite(sh)[1:],
    extra_back=ghost_head((98, 40)) + arrow([(84, 36), (92, 60)], curve=(76, 52)),
    extra_front=impact((160, 80), (1, 0))))

# Otoshi-zuki: descending punch.
st = zenkutsu()
sh = (96, 66)
T["otoshi-zuki"] = ("Otoshi-zuki", side_figure(
    st, sh, (99, 44),
    near_arm=[(120, 80), (140, 100)], far_arm=hikite(sh)[1:],
    extra_back=arrow([(118, 34), (150, 98)], curve=(158, 38)),
    extra_front=impact((143, 104), (0.8, 1), n=2)))

# Tate-zuki: vertical fist, elbow slightly bent.
st = zenkutsu()
sh = (96, 66)
T["tate-zuki"] = ("Tate-zuki", side_figure(
    st, sh, (99, 44),
    near_arm=[(120, 76), (144, 78)], far_arm=hikite(sh)[1:], near_kind="vfist",
    extra_front=impact((150, 78), (1, 0)) + inset("vertical")))

# Teisho-zuki: palm-heel strike.
sh = (96, 66)
T["teisho-zuki"] = ("Teisho-zuki", side_figure(
    st, sh, (99, 44),
    near_arm=[(121, 71), (144, 76)], far_arm=hikite(sh)[1:], near_kind="palm",
    extra_front=impact((152, 72), (1, 0))))

# Ura-zuki: close-range punch, palm up, elbow near the ribs.
sh = (96, 66)
T["ura-zuki"] = ("Ura-zuki", side_figure(
    st, sh, (99, 44),
    near_arm=[(104, 92), (130, 86)], far_arm=hikite(sh)[1:],
    extra_front=impact((135, 85), (1, -0.2)) + inset("up")))

# Yoko-zuki: front view, kiba-dachi, punch to the side, head turned.
T["yoko-zuki"] = ("Yoko-zuki", front_figure(
    "kiba", head_facing="right",
    arms=[("L", [(66, 88), (78, 106)], "fist"),
          ("R", [(145, 64), (170, 64)], "fist")],
    extra_front=impact((175, 64), (1, 0), n=2) + arrow([(130, 50), (166, 50)], dashed=False)))

outdir = sys.argv[1]
os.makedirs(outdir, exist_ok=True)
for key, (title, body) in T.items():
    with open(os.path.join(outdir, f"{key}.svg"), "w") as f:
        f.write(svg(body, title))
print(len(T))
