using Godot;
using System;

[GlobalClass]
public partial class CharacterMovement : Node
{
	public CharacterBody3D main_actor;
	[Export] private NavigationAgent3D nav_agent;
	[Export] private Node character_stats;
	private Node event_bus;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		event_bus = this.GetTree().Root.GetNode("EBus");
		main_actor = this.GetParent<CharacterBody3D>();
		character_stats = main_actor.GetNode("CharacterStats");

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		//Move(delta); //TODO remove this from here and move to the states machine or other system
		return;
	}

	public void SetDestination(Vector3 destination) 
	{
		nav_agent.TargetPosition = destination;
	}
	public void Move(double delta)
	{
		
		if (nav_agent.IsNavigationFinished())
		{
			main_actor.Velocity = Vector3.Zero;
			return;
		}

		Vector3 current_agent_pos = main_actor.GlobalTransform.Origin;
		Vector3 next_path_pos = nav_agent.GetNextPathPosition();

		Vector3 new_velocity = next_path_pos - current_agent_pos;
		new_velocity = new_velocity.Normalized();
		new_velocity = new_velocity * (float)character_stats.Get("current_movement_speed"); //TODO Use here the character movement speed

		main_actor.Velocity = new_velocity;

		main_actor.MoveAndSlide();

	}

}
