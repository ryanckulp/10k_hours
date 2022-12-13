class RecurringPostService
  attr_reader :post

  def self.call
    Post.recurring_with_rule.each { |p| new(p).call }
  end

  def initialize(post)
    @post = post
  end

  def call
    return unless should_create_repetition?
    create_post
  end

  def should_create_repetition?
    schedule = new_schedule
    previous_occurrence = schedule.previous_occurrence(Time.now)

    previous_occurrence.between?(1.hour.ago, Time.now)
  end

  def create_post
    new_post = Post.new(new_post_attributes)
    new_post.title += " (#{next_repetition_count} rep)"
    new_post.save!
  end

  def new_schedule
    s = IceCube::Schedule.new
    s.add_recurrence_rule(rule)
    s.start_time = rule.instance_variable_get(:@start_time)
    s
  end

  def rule
    r = RecurringSelect.dirty_hash_to_rule(post.recurring_rule)
    r.instance_variable_set(:@start_time, post.created_at)
    r
  end

  # TODO: upgrade except() to extract()
  def new_post_attributes
    attrs = post.attributes.except('created_at', 'updated_at', 'id', 'slug', 'recurring_rule', 'published_at', 'featured')
    attrs.merge('recurring_id' => post.id, 'published_at' => DateTime.now, 'visibility' => 'public')
  end

  # adding 2 to account for new post + parent post, which is the first true repetition
  def next_repetition_count
    (post.repetitions.count + 2).ordinalize
  end
end
