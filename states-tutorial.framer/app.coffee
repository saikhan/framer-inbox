# Import file "framer101_inbox"
inbox = Framer.Importer.load("imported/framer101_inbox@1x")

# on screen load
inbox.options.opacity = 0
inbox.overlay.opacity = 0
inbox.iconWrite.opacity = 0
inbox.iconWrite.rotation = -90

# constants
initialFaceScale = 0.5
nameOffsetY = 10

# collections
faces = []

for name, layer of inbox
	if name.match(/face./i)
		faces.push layer

for face in faces
	face.scale = initialFaceScale
	face.states.add
		on: 
			scale: 1
	face.states.animationOptions = curve: "spring(500, 30, 0)"

names = []

for name, layer of inbox
	if name.match(/name./i)
		names.push layer

for name in names
	name.y += nameOffsetY
	name.states.add
		on: 
			y: name.y - nameOffsetY
	name.states.animationOptions = curve: "spring(500, 30, 0)"
	
# states
inbox.overlay.states.add
	on:
		opacity: 1
inbox.overlay.states.animationOptions = curve: "spring(300, 30, 0)"

inbox.options.states.add
	on:
		opacity: 1
inbox.options.states.animationOptions = curve: "spring(300, 30, 0)"

inbox.iconWrite.states.add
	on:
		opacity: 1
		rotation: 0
inbox.iconWrite.states.animationOptions = curve: "spring(500, 30, 0)"

inbox.iconPlus.states.add
	on:
		opacity: 0
		rotation: 90
inbox.iconPlus.states.animationOptions = curve: "spring(500, 30, 0)"

# on click events
inbox.fab.onClick (event, layer) ->
	inbox.overlay.states.switch("on")
	inbox.options.states.switch("on")
	inbox.iconWrite.states.switch("on")
	inbox.iconPlus.states.switch("on")
	for face in faces
		face.states.switch("on")
	for name in names
		name.states.switch("on")

inbox.overlay.onClick (event, layer) ->
	inbox.overlay.states.switch("default")
	inbox.options.states.switch("default")
	inbox.iconWrite.states.switch("default")
	inbox.iconPlus.states.switch("default")
	for face in faces
		face.states.switch("default")
	for name in names
		name.states.switch("default")